#/usr/bin/perl

use strict;
use Tk;

system "nc -l -p 3000 >> testFile | tee output.log";

<<<<<<< HEAD
print "Checksum == ";
system "md5sum memoryImage.dd";

my $mw = MainWindow->new;
$mw->geometry("300x300");
$mw->title("NetMemAnalyzer");

$mw->Label( -text => "What would you like to analyze?" )
   ->grid(
	-row => 2,
	-column => 1,
	-columnspan =>2);
       
$mw->Button(
     -text => "View Strings",
     -command => sub{

			system ("strings memoryImage.dd | more");
		
		      })

      ->grid(
	-row => 3,
	-column => 1,
	-columnspan => 2);


MainLoop;
=======
     print "Checksum == ";
     system "md5sum memoryImage.dd";
	 
print "Select an Option to perform Analysis on the acquired memory image\n";
print " 1) View Strings\n\n";

print "Choice > ";
$choice = <>;

if ($choice == 1)
{
    system ("strings memoryImage.dd | more");
}
>>>>>>> c8c0fac828fdcc0418f27cd5d7c828bf72e2c808
