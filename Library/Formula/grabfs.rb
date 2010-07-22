require 'formula'

class Grabfs <Formula
  head 'http://macfuse.googlecode.com/svn/trunk/filesystems/grabfs/'
  homepage 'http://www.osxbook.com/book/bonus/chapter11/grabfs/'

  depends_on 'pcre'
  depends_on 'fuse' => :pkgconfig

  def patches
    { :p0 => DATA }
  end

  def install
    system "make"
    bin.install "windowfs"
  end
end
__END__
--- Makefile.orig	2008-08-19 19:03:46.000000000 +0200
+++ Makefile	2010-07-21 17:14:13.000000000 +0200
@@ -5,16 +5,15 @@
 #
 # http://code.google.com/p/macfuse/
 
-CXXFLAGS=-D_FILE_OFFSET_BITS=64 -D__FreeBSD__=10 -O -g -arch i386 -arch ppc -isysroot /Developer/SDKs/MacOSX10.5.sdk
-LDFLAGS=-L/usr/local/lib -lfuse -framework Carbon
+CXXFLAGS+=$(shell pkg-config --cflags fuse)
+LDFLAGS+=$(shell pkg-config --libs fuse) -framework Carbon
 
 # Configure this depending on where you installed pcrecpp
 # http://www.pcre.org
 #
-PCRECPP_PREFIX=/usr/local
 
-PCRECPP_CXXFLAGS=-I$(PCRECPP_PREFIX)/include
-PCRECPP_LDFLAGS=-arch i386 $(PCRECPP_PREFIX)/lib/libpcrecpp.a $(PCRECPP_PREFIX)/lib/libpcre.a
+PCRECPP_CXXFLAGS=$(shell pcre-config --cflags)
+PCRECPP_LDFLAGS=$(shell pcre-config --libs-cpp)
 
 all: windowfs
 
