require 'formula'

class T < Formula
  homepage 'http://stevelosh.com/projects/t/'
  version '1.2.0'
  url 'https://bitbucket.org/sjl/t', { :using => :hg, :tag => "v#{version}" }
  head 'https://bitbucket.org/sjl/t', { :using => :hg }

  def install
    bin.install 't.py' => 't'
  end
end
