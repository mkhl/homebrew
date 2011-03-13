require 'formula'

class AnsiColor < Formula
  homepage 'http://code.google.com/p/ansi-color/'
  url 'http://ansi-color.googlecode.com/files/ansi-color-0.6.tar.gz'
  sha1 'fc9fb252da32b70380ad6ad1d5be3ec418446259'

  def install
    bin.install 'color'
    man1.install gzip('color.1')
  end
end
