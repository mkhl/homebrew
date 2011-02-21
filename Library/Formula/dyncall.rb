require 'formula'

class Dyncall < Formula
  homepage 'http://dyncall.org/'
  url 'http://dyncall.org/r0.6/dyncall-0.6.tar.gz'
  md5 '8e1e47285374222d1ea2f6bf6ecd78c3'

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make install"
  end
end
