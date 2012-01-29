require 'formula'

class Kona < Formula
  homepage 'https://github.com/kevinlawler/kona'
  head 'https://github.com/kevinlawler/kona.git'

  def install
    bin.mkpath
    system "make"
    system "make", "PREFIX=#{prefix}", "install"
  end
end
