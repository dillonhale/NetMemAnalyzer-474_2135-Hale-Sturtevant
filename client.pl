#!/usr/bin/perl -w

use strict;

my $blockSize;
my $serverIP;
my $serverPort;

print "Enter Block Size: ";
$blockSize = <>;

print "Enter Server IP: ";
$serverIP = <>;

print "Enter Server Port: ";
$serverPort = <>;

chomp($blockSize);
chomp($serverIP);
chomp($serverPort);

my $transferFile = `dd if=/dev/fmem bs=$blockSize of=memoryImage.dd`;

system "nc $serverIP $serverPort < memoryImage.dd";
