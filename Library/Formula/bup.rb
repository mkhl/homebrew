require 'formula'

class Bup < Formula
  homepage 'https://github.com/apenwarr/bup'
  version '0.24b'
  url "https://github.com/apenwarr/bup/tarball/bup-#{version}"
  md5 '94e6e0057c41f04ee5dfd5467905f2b7'

  def install
    ENV['ARCHFLAGS'] = Hardware.is_32_bit? ? '-arch i386' : '-arch x86_64'
    system 'make',
           "BINDIR=#{bin}",
           "MANDIR=#{man}",
           "DOCDIR=#{doc}",
           "LIBDIR=#{lib}/bup",
           "CFLAGS=#{ENV['CFLAGS']}"
           'install'
  end
end
