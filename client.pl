#!/usr/bin/perl

my $countVar = 4096;
my $serverIP = "127.0.0.1";

     print "Enter block size: ";
     $countVar = <>;

     print "Enter the Server IP: ";
     $serverIP = <>;

     print "Enter the Server Port: ";
     $serverPort = <>; 

     print "Please Wait.. Creating Memory Image.";
     my $transferFile = `dd if=/dev/fmem count=4096 of=memoryImage`;

     system "nc $serverIP $serverPort < memoryImage | tee output.log";
     print "Checksum == ";
     system "md5sum memoryImage.dd";
