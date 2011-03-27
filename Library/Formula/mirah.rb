require 'formula'

class Mirah < Formula
  homepage 'http://mirah.org'
  version '0.0.8'
  url 'https://github.com/downloads/mirah/mirah/mirah-0.0.8.dev.zip'
  md5 '3052c85f81b9c5e8c5cf1505037a6734'

  def install
    rm Dir['bin/*.bat']
    libexec.install %w[bin lib examples]
    bin.mkpath
    Dir[libexec+"bin/*"].each do |f|
      ln_s f, bin+File.basename(f)
    end
  end
end
