require 'formula'

class Pwman < Formula
  homepage 'http://pwman.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/pwman/pwman/pwman-0.4.4/pwman-0.4.4.tar.gz'
  md5 '29ddc5028391e224995151b4f959c51a'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
