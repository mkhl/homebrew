require 'formula'

class Srw < Formula
  homepage 'http://deepcube.net/code/srw/'
  head 'http://bitbucket.org/emg/srw', :using => :hg

  def patches
    {:p0 => DATA}
  end

  def install
    system "make", "PREFIX=#{prefix}","install"
  end
end

__END__
Let Ctrl-D signal EOF to the subprocess.
--- srw.c.orig	2010-11-08 22:46:28.000000000 +0100
+++ srw.c	2010-11-08 22:57:43.000000000 +0100
@@ -209,6 +209,8 @@
 					case CTRL('a') : cur = 0;                 break;
 					case CTRL('b') : cur = MAX(0, cur - 1);   break;
 					case CTRL('d') :
+						if (cur == 0 && len == 0)
+							quit(0);
 						if (cur != len) {
 							memmove(usrbuf + cur, usrbuf + cur + 1, len - cur - 1);
 							len--;
