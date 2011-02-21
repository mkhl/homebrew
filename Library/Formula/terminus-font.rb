require 'formula'

class TerminusFont < Formula
  homepage 'http://terminus-font.sourceforge.net/'
  version '4.35'
  url "http://downloads.sourceforge.net/project/terminus-font/terminus-font-#{version}/terminus-font-#{version}.tar.gz"
  md5 'aae64091ad9c7d1d0f8942ffa9026c36'

  def caveats
    <<-EOS.undent
      To make the font available to X11, add this to your xinitrc.d:
        xset +fp "#{share}/fonts/terminus"
    EOS
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install-pcf"
    system "make", "fontdir"
  end
end
