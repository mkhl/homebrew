require 'formula'

class Archivemount <Formula
  url 'http://www.cybernoia.de/software/archivemount/archivemount-0.6.1.tar.gz'
  md5 'e591aff17e84beb1962ede825f7078bb'
  homepage 'http://www.cybernoia.de/software/archivemount/'

  depends_on 'libarchive'
  depends_on 'fuse' => :pkgconfig

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make install"
  end
end
