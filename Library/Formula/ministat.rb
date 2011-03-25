require 'formula'

class Ministat < Formula
  homepage 'https://github.com/codahale/ministat'
  head 'https://github.com/codahale/ministat/tarball/master'
  md5 'be42d72d6628df19a1246b1b37838125'

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
