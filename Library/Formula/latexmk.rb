require 'formula'

class Latexmk < Formula
  url 'http://www.phys.psu.edu/~collins/software/latexmk-jcc/latexmk-418.zip'
  homepage 'http://www.phys.psu.edu/~collins/software/latexmk-jcc/'
  md5 '3d24ba3d51c4a0e6c6de9a7165ddc8b0'

  def install
    bin.install 'latexmk.pl' => 'latexmk'
    man1.install gzip('latexmk.1')
  end
end
