require 'formula'

class TamsynFont < Formula
  homepage 'http://www.fial.com/~scott/tamsyn-font/'
  url 'http://www.fial.com/~scott/tamsyn-font/download/tamsyn-font-1.6.tar.gz'
  md5 'e6defc76bdcf5ee1c4d4575b2a182a8e'

  def caveats
    <<-EOS.undent
      To make the font available to X11, add this to your xinitrc.d:
        xset +fp "#{share}/fonts/tamsyn"
    EOS
  end

  def install
    system "mkfontdir"
    system "mkfontscale"
    (share+"fonts/tamsyn").install Dir['fonts.*']
    (share+"fonts/tamsyn").install Dir['*.pcf']
  end
end
