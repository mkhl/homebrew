require 'formula'

class Txt2man < Formula
  homepage 'http://mvertes.free.fr/'
  url 'http://mvertes.free.fr/download/txt2man-1.4.8.tar.gz'
  md5 '2ee6d7cc38c42b98f4d8c1eb815bd888'

  def patches
    { :p0 => DATA }
  end

  def install
    system "make", "prefix=#{prefix}", "install"
  end
end

__END__
Fix man path.
--- Makefile.orig	2003-07-07 12:37:36.000000000 +0200
+++ Makefile	2011-01-18 15:40:57.000000000 +0100
@@ -1,9 +1,9 @@
 prefix ?= /usr/local
 
 install: txt2man.1
-	mkdir -p $(prefix)/bin $(prefix)/man/man1
+	mkdir -p $(prefix)/bin $(prefix)/share/man/man1
 	cp -p txt2man $(prefix)/bin/
-	cp -p txt2man.1 $(prefix)/man/man1
+	cp -p txt2man.1 $(prefix)/share/man/man1
 
 txt2man.1 txt2man.man: txt2man
 	./txt2man -h 2>&1 | ./txt2man -t txt2man >$@
