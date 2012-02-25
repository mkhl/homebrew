require 'formula'

class Libixp < Formula
  homepage 'http://libs.suckless.org/libixp'
  url 'http://dl.suckless.org/libs/libixp-0.5.tar.gz'
  md5 '2a394310c209605ba54ecf5eab518bff'

  def install
    inreplace 'config.mk' do |s|
      s.change_make_var! 'PREFIX', prefix
    end
    system "make install"
  end
end
