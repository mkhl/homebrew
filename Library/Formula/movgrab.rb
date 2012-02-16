require 'formula'

class Movgrab < Formula
  homepage 'https://sites.google.com/site/columscode/home/movgrab'
  url 'https://sites.google.com/site/columscode/files/movgrab-1.1.10.tgz'
  sha1 '2a87105501a3397d513c495d9d1f982ef2e09195'

  def install
    ENV.remove_cc_etc
    system "./configure", "--prefix=#{prefix}", "--enable-ssl"
    system "make"
    system "make", "install"
  end
end
