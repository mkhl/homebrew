require 'formula'

class Mpage < Formula
  homepage 'http://www.mesa.nl/pub/mpage/'
  url 'http://www.mesa.nl/pub/mpage/mpage-2.5.6.tgz'
  md5 '489663c9246e47915cea931348e5175d'

  def install
    system "make"
    system "make", "PREFIX=#{prefix}", "MANDIR=#{man1}", "default", "install"
  end
end
