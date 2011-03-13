require 'formula'

class Ghi < Formula
  homepage 'https://gist.github.com/381173'
  head 'https://gist.github.com/raw/381173/5408f1091b36dc4b3b2f1d912f9af4eb87177fb8/ghi.rb'
  md5 '8f61b2b62ec9bcdc48dd7d3e57945623'

  def install
    bin.install 'ghi.rb' => 'ghi'
  end
end
