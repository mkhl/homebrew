require 'formula'

class Vttest < Formula
  homepage 'http://invisible-island.net/vttest/vttest.html'
  url 'http://invisible-island.net/datafiles/release/vttest.tar.gz'
  md5 '17c5e669699b489a97510536df878de1'
  version '2.7'

  def install
    system "./configure", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make install"
  end
end
