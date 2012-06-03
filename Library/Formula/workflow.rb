require 'formula'

class Workflow < Formula
  homepage 'http://github.com/mdipierro/workflow'
  head 'https://github.com/mdipierro/workflow.git', :using => :git

  def install
    bin.install 'workflow.py' => 'workflow'
  end
end
