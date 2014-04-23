#/usr/bin/perl

use strict;
use Tk;

my $imageFile = "image.dd";

system "nc -w60 -l -p 31 >> image.dd &";

my $mw = MainWindow->new;
$mw->geometry("380x300");
$mw->title("NetMemAnalyzer");

$mw->Label( -text => "Welcome to NetMemAnalyzer \nPlease wait for the image to completly transfer before analyzing!", -foreground=>'blue')
   ->grid(
	-row => 1,
	-column => 1,
	-columnspan =>2);

$mw->Label( -text => "What would you like to analyze?" )
   ->grid(
	-row => 2,
	-column => 1,
	-columnspan =>2);
       
$mw->Button(
     -text => "View Strings",
     -command => sub{

			system ("strings " . $imageFile . " | more");
		
		      })
      ->grid(
	-row => 3,
	-column => 1,
	-columnspan => 2);

$mw->Button(
     -text => "Carve JPG Files",
     -command => sub{

			carveJPG();
		
		      })
      ->grid(
	-row => 4,
	-column => 1,
	-columnspan => 2);

$mw->Button(
     -text => "Carve GIF Files",
     -command => sub{

			carveGIF();
		
		      })
      ->grid(
	-row => 5,
	-column => 1,
	-columnspan => 2);

$mw->Button(
     -text => "Carve PNG Files",
     -command => sub{

			carvePNG();
		
		      })
      ->grid(
	-row => 6,
	-column => 1,
	-columnspan => 2);

$mw->Button(
     -text => "Exit",
     -command => sub{

			system ("strings " . $imageFile . " | more");
		
		      })
      ->grid(
	-row => 7,
	-column => 1,
	-columnspan => 2);

MainLoop;

sub carveJPG()
{
open (IMAGE, "<", $imageFile) or die "Error opening image. \n";

# Open file in binary mode
binmode (IMAGE);

my $fileNumber = 0;
my $hex;
my $fileBuffer;

#Read jpg files in 65k blocks
while ( (read (IMAGE, $fileBuffer, 65000)) > 0 ) {

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

sub carveGIF()
{
open (IMAGE, "<", $imageFile) or die "Error opening image. \n";

# Open file in binary mode
binmode (IMAGE);

my $fileNumber = 0;
my $hex;
my $fileBuffer;

#Read jpg files in 65k blocks
while ( (read (IMAGE, $fileBuffer, 65000)) > 0 ) {

                    # Convert input buffer to hex
                    $hex = unpack('H*', $fileBuffer);

                    # Search for jpg header and trailer
                    if ($hex =~ m/(47494638(?:(?!47494638).)*1110003b)/i)
                    {                 
                                        # Trim any leading hex and trailing zeros off of the buffer
					$hex =~ s/^.*(?=47494638)//g;
                                        $hex =~ s/(0*)$//g;

                                        # Save carved jpg to a file
                                        open (MYFILE, '>' . $fileNumber . '.gif');
                                        print (MYFILE pack('H*', $hex));
                                        close (MYFILE);

                                        $fileNumber++;
                    }

	}  
}

sub carvePNG()
{
open (IMAGE, "<", $imageFile) or die "Error opening image. \n";

# Open file in binary mode
binmode (IMAGE);

my $fileNumber = 0;
my $hex;
my $fileBuffer;

#Read jpg files in 65k blocks
while ( (read (IMAGE, $fileBuffer, 65000)) > 0 ) {

                    # Convert input buffer to hex
                    $hex = unpack('H*', $fileBuffer);

                    # Search for jpg header and trailer
                    if ($hex =~ m/(89504e470d0a1a0a(?:(?!89504e470d0a1a0a).)*ae426082)/i)
                    {                 
                                        # Trim any leading hex and trailing zeros off of the buffer
					$hex =~ s/^.*(?=89504e470d0a1a0a)//g;
                                        $hex =~ s/(0*)$//g;

                                        # Save carved jpg to a file
                                        open (MYFILE, '>' . $fileNumber . '.png');
                                        print (MYFILE pack('H*', $hex));
                                        close (MYFILE);
	
                                        $fileNumber++;
                    }

}
}
}
