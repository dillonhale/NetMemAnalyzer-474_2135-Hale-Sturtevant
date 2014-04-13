#!/usr/bin/perl -w

use strict;
use Tk;

my $countVar;
my $serverIP;
my $serverPort;


my $mw = MainWindow->new;
$mw->geometry("300x300");
$mw->title("NetMemAnalyzer");



#creates a label called "Enter blocksize" located in row2, column1, with a width of one columnspan in the window
$mw->Label( -text => "Enter blocksize" )
   ->grid(
	-row => 2,
	-column => 1,
	-columnspan =>1);

$mw->Label( -text => "Enter Server IP" )
   ->grid(
	-row => 3,
	-column => 1,
	-columnspan =>1);

$mw->Label( -text => "Enter Server Port" )
   ->grid(
	-row => 4,
	-column => 1,
	-columnspan =>1);


my $blocksize_entered = $mw->Entry( -width => 10);
$blocksize_entered
    ->grid(
	-row =>2,
	-column => 2,
	-columnspan =>1);


my $ip_entered = $mw->Entry( -width => 10);
$ip_entered
    ->grid(
	-row =>3,
	-column => 2,
	-columnspan =>1);

my $port_entered = $mw->Entry( -width => 10);
$port_entered
     ->grid(
	  -row =>4,
	  -column => 2,
	  -columnspan => 1);  	

$mw->Button(
     -text => "Connect to server",
     -command => sub{
			#countVar = 4096
			#serverIP = 127.0.0.1
			 $countVar = $blocksize_entered->get; 
			 $serverIP = $ip_entered->get;
			 $serverPort = $port_entered;	
			
			
			#extra
			$mw->Label( -text => "Please Wait.." )
			   ->grid(
				-row => 6,
				-column => 1,
				-columnspan =>1);

			my $count =1;
sub connected{

	$mw->destroy;
		my $new = MainWindow->new;
		$new->geometry("300x300");
		$new->title("NetMemAnalyzer");
	$new->Label( -text => "Successfully connected to server" )
   ->grid(
	-row => 2,
	-column => 1,
	-columnspan =>2);


my $transferFile = `dd if=/dev/fmem count=4096 of=memoryImage.dd`;

    system "nc $serverIP $serverPort < memoryImage | tee output.log";
   print "Checksum == ";
  system "md5sum memoryImage.dd";

}
print $count;
if($count == 1)
{
connected();
}
			
		      })

      ->grid(
	-row => 5,
	-column => 1,
	-columnspan => 2);


MainLoop;
