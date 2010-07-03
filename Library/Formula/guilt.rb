require 'formula'

class Guilt < Formula
  homepage 'http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/man/'
  url 'http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/guilt-0.33.tar.bz2'
  mirror 'http://www.mirrorservice.org/sites/ftp.kernel.org/pub/linux/kernel/people/jsipek/guilt/guilt-0.33.tar.bz2'
  md5 'de2d3b82d3e08c8c6a940bd31f47d758'

  depends_on 'xmlto' => :optional

  def patches
    DATA
  end

  def install
    system "make", "PREFIX=#{prefix}", "install"
    system "make", "mandir=#{man}", "install-doc" if Formula.factory('xmlto').installed?
  end
end

__END__
Instead of GNU expr(1), use a few POSIX shell features.
--- guilt-0.33/Documentation/cmd-list.sh.orig	2010-04-16 04:44:49.000000000 +0200
+++ guilt-0.33/Documentation/cmd-list.sh	2010-07-03 19:07:50.000000000 +0200
@@ -11,12 +11,12 @@
 {print $0; exit}
 '`
 
-	len=`expr length "$cmd"`
+	len="${#cmd}"
 
 	if [ -z "$desc" ]; then
 		echo "No description found in $cmd.txt" >&2
 		exit 1
-	elif [ "`expr substr \"$desc\" 1 $len`" != "$cmd" ]; then
+	elif [ "${desc:0:len}" != "$cmd" ]; then
 		echo "Description does not match $cmd: $desc" >&2
 		exit 1
 	fi
