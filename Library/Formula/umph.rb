require 'formula'

class Umph < Formula
  homepage 'http://umph.googlecode.com/'
  url 'http://umph.googlecode.com/files/umph-0.1.8.tar.gz'
  md5 '2651413fa3a6173116f95fbcf2898744'

  def install
    system "perl", "Makefile.PL", "INSTALL_BASE=#{prefix}"
    system "make"
    system "make INST_MAN1DIR=#{man1} install"
  end
end
