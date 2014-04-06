#/usr/bin/perl

system "nc -l -p 3000 >> testFile | tee output.log";

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