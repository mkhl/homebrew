require 'formula'

class SpringRoo < Formula
  homepage 'http://www.springsource.org/spring-roo'
  url 'http://s3.amazonaws.com/dist.springframework.org/release/ROO/spring-roo-1.2.2.RELEASE.zip'
  sha1 '1a1d27617d7029899dc96caa53b51a3b80d01d21'
  version '1.2.2'

  def install
    rm_f Dir["bin/*.bat"]
    libexec.install %w[annotations bin bundle conf docs legal samples]
    bin.mkpath
    ln_s libexec+'bin/roo.sh', bin+'roo'
  end
end
