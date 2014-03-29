#/usr/bin/perl

system "nc -l -p 3000 >> testFile | tee output.log";

     print "Checksum == ";
     system "md5sum memoryImage.dd";
