require 'formula'

class Mvel < Formula
  homepage 'http://mvel.codehaus.org/'
  version '2.0.19'
  url "http://repository.codehaus.org/org/mvel/mvel2/#{version}/mvel2-#{version}.jar"
  md5 '90d8eb7b83af86b5f11f9bb56807a998'

  def script
<<-EOS
#!/bin/sh
# Run MVEL.

exec java -jar "#{libexec}/mvel2-#{version}.jar" "$@"
EOS
  end

  def install
    libexec.install "mvel2-#{version}.jar"
    bin.mkpath
    (bin+'mvel').write script
  end
end
