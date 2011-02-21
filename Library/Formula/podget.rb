require 'formula'

class Podget < Formula
  homepage 'http://podget.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/podget/podget/podget-0.6/podget-0.6.tar.gz'
  md5 'd7d379271fecea1a474e6deaf0c8c373'

  def install
    system "make", "prefix=#{prefix}", "install"
  end
end
