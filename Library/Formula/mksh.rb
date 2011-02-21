require 'formula'

class CpioDownloadStrategy < CurlDownloadStrategy
  def stage
    system "gzcat #{@tarball_path} | cpio -id"
    chdir
  end
end

class Mksh < Formula
  homepage 'http://mirbsd.de/mksh'
  version '0.40d'
  url 'https://www.mirbsd.org/MirOS/dist/mir/mksh/mksh-R40d.cpio.gz',
    :using => CpioDownloadStrategy
  md5 'c6428401103367730a95b99284bf47dc'

  def install
    system "sh ./Build.sh -r -combine"
    doc.install "dot.mkshrc"
    man1.install gzip("mksh.1")
    bin.install "mksh"
  end
end
