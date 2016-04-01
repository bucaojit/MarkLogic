#!/usr/bin/perl -w
#

# Script works on all files in directory
# Ex: ./cleansar /tmp/saradata/
# Note: ending '/' in directory name needed
# Output file will be <orig filename>.clean

my $directory = $ARGV[0];
if (not defined $directory) {
  die "No directory name input\n"
}

opendir(DH, $directory);
my @files = readdir(DH);
closedir(DH);

foreach my $file (@files)
{
  open FILE, $directory.$file or die "Unable to open file: $file";
  open OUTPUT, '>'.($directory.$file . ".clean") or die "Unable to open file: $!";

  while(my $row = <FILE>) {
    $row =~ s/AM//g;
    $row =~ s/PM//g;
    $row =~ s/am//g;
    $row =~ s/pm//g;
    print OUTPUT $row
  }
  close FILE;
  close OUTPUT;

}

