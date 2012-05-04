require 'formula'

class Moreutils < Formula
  homepage 'http://packages.debian.org/unstable/utils/moreutils'
  url 'http://mirrors.kernel.org/debian/pool/main/m/moreutils/moreutils_0.46.tar.gz'
  mirror 'http://ftp.us.debian.org/debian/pool/main/m/moreutils/moreutils_0.46.tar.gz'
  md5 '658f9cc6b6dcc0b50dcff714e13b22dc'

  # depends_on 'docbook2x' => :optional

  def patches
    { :p0 => DATA }
  end

  def install
    if Formula.factory('docbook2x').installed?
      system "make", "DOCBOOK2XMAN=docbook2man", "all"
      system "make", "PREFIX=#{prefix}", "install"
    else
      scripts = %w[vidir vipe ts combine zrun chronic]
      binaries = %w[isutf8 ifne pee sponge mispipe lckdo parallel]
      system "make", *binaries
      bin.install scripts + binaries
    end
  end
end

__END__
The `ifdata` util fails to build.
--- Makefile.orig	2010-10-29 21:47:09.000000000 +0200
+++ Makefile	2011-02-14 15:16:49.000000000 +0100
@@ -1,4 +1,4 @@
-BINS=isutf8 ifdata ifne pee sponge mispipe lckdo parallel
+BINS=isutf8 ifne pee sponge mispipe lckdo parallel
 PERLSCRIPTS=vidir vipe ts combine zrun chronic
 MANS=sponge.1 vidir.1 vipe.1 isutf8.1 ts.1 combine.1 ifdata.1 ifne.1 pee.1 zrun.1 chronic.1 mispipe.1 lckdo.1 parallel.1
 CFLAGS=-O2 -g -Wall
