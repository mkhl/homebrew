require 'formula'

class Abcl < Formula
  homepage 'http://common-lisp.net/project/armedbear/'
  version '1.0.1'
  url "http://common-lisp.net/project/armedbear/releases/#{version}/abcl-bin-#{version}.tar.gz"
  md5 'bd95a55df30469b4f6d85af7c5ede297'
  head 'svn://common-lisp.net/project/armedbear/svn/trunk/abcl'

  def script
<<-EOS
#!/bin/sh
# Run Armed Bear Common Lisp.

# Add ABCL jar to CLASSPATH.
ABCL="${CLASSPATH:+$CLASSPATH:}#{libexec}/#{name}.jar:#{libexec}/#{name}-contrib.jar"

exec java -cp "$ABCL" org.armedbear.lisp.Main "$@"
EOS
  end

  def install
    system "ant" if ARGV.build_head?
    libexec.install 'abcl.jar'
    libexec.install 'abcl-contrib.jar'
    (bin+'abcl').write script
  end
end
