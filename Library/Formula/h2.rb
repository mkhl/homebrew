require 'formula'

class H2 < Formula
  homepage 'http://h2database.com/'
  version '1.3.164'
  url 'http://www.h2database.com/h2-2012-02-03.zip'
  md5 'bb07381eaa84e3f74cf3a26e4b0647c5'

  def install
    jar = "h2-#{version}.jar"
    inreplace 'bin/h2.sh', %Q[cp="$dir/#{jar}"], %Q[cp="#{libexec}/#{jar}"]
    libexec.install "bin/#{jar}"
    bin.install 'bin/h2.sh' => 'h2'
    doc.install Dir['docs/*']
  end
end
