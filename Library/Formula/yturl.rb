require 'formula'

class Yturl < Formula
  homepage 'https://github.com/cdown/yturl'
  head 'https://github.com/cdown/yturl.git'

  def install
    bin.install 'yturl'
    man1.install gzip('yturl.1')
  end
end
