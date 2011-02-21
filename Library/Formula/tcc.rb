require 'formula'

class Tcc < Formula
  homepage 'http://bellard.org/tcc/'
  url 'http://download.savannah.nongnu.org/releases/tinycc/tcc-0.9.25.tar.bz2'
  md5 '991c2a1986cce15f03ca6ddc86ea5f43'

  def install
    ENV.j1
    system "./configure", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make install"
  end
end
