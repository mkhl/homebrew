require 'formula'

class Shql < Formula
  homepage 'http://momjian.us/'
  url 'http://momjian.us/download/shql.1.3.tgz'
  md5 '4ca98b8e9a7b6d4c31d1e41d7391084a'

  def install
    bin.install 'shql'
    doc.install 'demo.shql'
  end
end
