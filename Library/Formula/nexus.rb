require 'formula'

class Nexus < Formula
  homepage 'http://nexus.sonatype.org/'
  version '1.9.1'
  url "http://nexus.sonatype.org/downloads/nexus-oss-webapp-#{version}-bundle.tar.gz"
  md5 '719c7c585125e00171dddd6e4cdc9320'

  skip_clean :all

  def install
    rm_rf Dir['bin/jsw/{linux,solaris,windows}-*']
    work = var+'nexus'
    chdir("nexus-oss-webapp-#{version}/") do
      inreplace 'conf/plexus.properties', 'nexus-work=${basedir}/../sonatype-work/nexus', "nexus-work=#{work}"
      libexec.install %w[bin conf logs runtime]
      prefix.install %w[LICENSE.txt NOTICE.txt]
    end
    work.mkpath
    bin.mkpath
    script = libexec+"bin/jsw/macosx-universal-#{MacOS.prefer_64_bit? ? 64 : 32}/nexus"
    ln_s script, bin+'nexus'
  end

  def caveats
    <<-EOS.undent
      Nexus default settings:
        Location: http://localhost:8081/nexus/
        Username: admin
        Password: admin123
    EOS
  end
end
