require 'formula'

class Libarchive < Formula
  homepage 'http://code.google.com/p/libarchive/'
  url 'http://libarchive.googlecode.com/files/libarchive-2.8.4.tar.gz'
  md5 '83b237a542f27969a8d68ac217dc3796'

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make install"
  end
end
