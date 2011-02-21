require 'formula'

class Dagger < Formula
  homepage 'http://freewarepoint.de/dagger/'
  url 'http://freewarepoint.de/dagger/dagger-0.3.2.tar.gz'
  md5 'c482a7bca5d7e1ffa2157358734956d3'

  def install
    bin.install 'dagger'
    doc.install 'daggerrc' => 'example.daggerrc'
    man.install Dir['man/*']
  end
end
