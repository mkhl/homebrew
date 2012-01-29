require 'formula'

class Travis < GithubGistFormula
  homepage 'https://gist.github.com/1676577'
  head 'https://raw.github.com/gist/1676577/travis.rb'
  url 'https://raw.github.com/gist/1676577/eb66596ba3d69bf1ba9d782ce7ddaaab295cc4db/travis.rb'
  md5 '950e35c4e43118a9883d6137ee4c2777'

  def install
    bin.install 'travis.rb' => 'travis'
  end
end
