#/usr/bin/perl

use strict;
use Tk;

my $mw = MainWindow->new;
$mw->geometry("300x300");
$mw->title("NetMemAnalyzer");

$mw->Label( -text => "What would you like to analyze?",-anchor => 'n')
   ->grid(
	-row => 2,
	-column => 1,
	-columnspan =>2);
       
$mw->Button(
     -text => "View Strings",
     -command => sub{

			system ("strings memoryImage.dd");
		
		      })


      ->grid(
	-row => 3,
	-column => 1,
	-columnspan => 2);

$mw->Button(
     -text => "Extract JPG Files from Image",
     -command => sub{

			\&extractJPG();
		
		      })

      ->grid(
	-row => 4,
	-column => 1,
	-columnspan => 2);

sub extractJPG()
{
	# Change to path of dd image
my $imageFile = "image3.dd";

open (IMAGE, "<", $imageFile) or die "Error opening image. \n";

# Open file in binary mode
binmode (IMAGE);

my $fileNumber = 0;
my $fileBuffer;

#Read jpg files in 65k blocks
while ( (read (IMAGE, $fileBuffer, 65000)) > 0 ) {

                    # Convert input buffer to hex
                    my $hex = unpack('H*', $fileBuffer);

                    # Search for jpg header and trailer
                    if ($hex =~ m/(ffd8ffe0(?:(?!ffd8).)*ffd9)/i)
                    {                 
                                        # Trim any leading hex and trailing zeros off of the buffer
					$hex =~ s/^.*(?=ffd8ffe0)//g;
                                        $hex =~ s/(0*)$//g;

                                        # Save carved jpg to a file
                                        open (MYFILE, '>' . $fileNumber . '.jpeg');
                                        print (MYFILE pack('H*', $hex));
                                        close (MYFILE);

                                        $fileNumber++;
                    }

}  

}

MainLoop;
