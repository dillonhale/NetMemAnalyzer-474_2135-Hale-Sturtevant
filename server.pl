#/usr/bin/perl

use strict;
use Tk;
use Digest::SHA qw(sha256_hex);

my $imageFile = "image.dd";
my %fileList;

#system "nc -w60 -l -p 31 >> image.dd &";

my $mw = MainWindow->new;
$mw->geometry("570x370");
$mw->title("NetMemAnalyzer");

$mw->Label( -text => "Welcome to NetMemAnalyzer \nPlease wait for the image to completly transfer before analyzing!", -foreground=>'blue')
   ->grid(
	-row => 1,
	-column => 1,
	-columnspan =>3);

$mw->Label( -text => "Options" )
   ->grid(
	-row => 3,
	-column => 1,
	-columnspan =>2);
       
$mw->Button(
     -text => "View Strings",
     -command => sub{

		system ("strings " . $imageFile . " | more");
		
	})
      ->grid(
	-row => 4,
	-column => 1,
	-columnspan => 2);

$mw->Button(
     -text => "Carve JPG Files",
     -command => sub{

		carveJPG();
		
	})
      ->grid(
	-row => 5,
	-column => 1,
	-columnspan => 2);

$mw->Button(
     -text => "Carve GIF Files",
     -command => sub{

		carveGIF();
		
	})
      ->grid(
	-row => 6,
	-column => 1,
	-columnspan => 2);

$mw->Button(
     -text => "Carve PNG Files",
     -command => sub{
		
		carvePNG();
		compareFileList();
		
	})
      ->grid(
	-row => 7,
	-column => 1,
	-columnspan => 2);

$mw->Button(
     -text => "Exit",
     -command => sub{

			system ("strings " . $imageFile . " | more");
		
	})
      ->grid(
	-row => 10,
	-column => 3,
	-columnspan => 3);

my $statusWindow = $mw->Text(
     -width => 60,
     -height => 20)
      ->grid(
	-row => 3,
	-column => 3,
	-rowspan => 6);

MainLoop;

sub carveJPG()
{
	open (IMAGE, "<", $imageFile) or die "Error opening image. \n";

	# Open file in binary mode
	binmode (IMAGE);

	my $fileNumber = 0;
	my $hex;
	my $fileBuffer;
	my $fileChecksum;
	my %fileList;

		#Read jpg files in 65k blocks
		while ( (read (IMAGE, $fileBuffer, 65000)) > 0 ) 
		{

			# Convert input buffer to hex
			$hex = unpack('H*', $fileBuffer);

			# Search for jpg header and trailer
			if ($hex =~ m/(ffd8ffe0(?:(?!ffd8).)*ffd9)/i)
			{                 
				# Trim any leading hex and trailing zeros off of the buffer
				$hex =~ s/^.*(?=ffd8ffe0)//g;
				$hex =~ s/(0*)$//g;

				print $hex . "\n\n";

				# Save carved jpg to a file
				open (MYFILE, '>' . $fileNumber . '.jpeg');
				print (MYFILE pack('H*', $hex));
				close (MYFILE);

				$fileNumber++;
			}

	
		}

	$statusWindow->insert("1.0", "*** JPG CARVE STATUS ***\n" . $fileNumber . " jpg files were carved from memory image");

}


sub carvePNG()
{
	open (IMAGE, "<", $imageFile) or die "Error opening image. \n";

	# Open file in binary mode
	binmode (IMAGE);

	my $fileNumber = 0;
	my $hex;
	my $fileBuffer;
	my $fileChecksum;

		#Read jpg files in 65k blocks
		while ( (read (IMAGE, $fileBuffer, 65000)) > 0 ) 
		{

			# Convert input buffer to hex
			$hex = unpack('H*', $fileBuffer);

			# Search for jpg header and trailer
			if ($hex =~ m/(89504e470d0a1a0a(?:(?!89504e470d0a1a0a).)*ae426082)/i)
			{                 
				# Trim any leading hex and trailing zeros off of the buffer
				$hex =~ s/^.*(?=89504e470d0a1a0a)//g;
				$hex =~ s/(0*)$//g;

				$fileChecksum = sha256_hex(pack('H*', $hex));
				#$fileList{$fileChecksum} = $fileNumber . ".png";
				$fileList{$fileChecksum} = $fileNumber . ".png";		
				print $fileChecksum . "\n";

				# Save carved jpg to a file
				open (MYFILE, '>' . $fileNumber . '.png');
				print (MYFILE pack('H*', $hex));
				close (MYFILE);

				$fileNumber++;
			}

	
		}

	$statusWindow->insert("1.0", "*** PNG CARVE STATUS ***\n" . $fileNumber . " png files were carved from memory image");

}

sub compareFileList()
{
	open CHECKSUMFILE, "file_list.txt" or die $!;

	while (defined (my $checkSum = <CHECKSUMFILE>)) {
	    chomp $checkSum;
	    my $size = length $fileList{$checkSum};
	    print "$checkSum\n";                # output size of line
	}

#	while (my $checkSum = <CHECKSUMFILE>) 
#	{
#		print $fileList{$checkSum};		
		#print $fileList{chomp($_)};
		#if (exists ($fileList{$_}))
		#{
		#	print "   MATCH - " . $fileList{$_};
		#}
		#else
		#{
		#	print "   NO-MATCH - " . $fileList{$_};			
		#	#$statusWindow->insert("   NOMATCH - " . $fileList{$_});
		#}
#	}


	foreach my $key (keys %fileList)
	{
		#print "$key \ncosts\n $fileList{$key}\n\n\n";
	}
}
