require 'formula'

class GitWip < Formula
  homepage 'https://github.com/bartman/git-wip'
  head 'https://github.com/bartman/git-wip.git', :using => :git

  def install
    bin.install 'git-wip'
    libexec.install ['emacs', 'vim']
  end
end
