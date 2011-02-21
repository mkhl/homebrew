require 'formula'

class Kawa < Formula
  homepage 'http://www.gnu.org/software/kawa/'
  url 'http://ftpmirror.gnu.org/kawa/kawa-1.11.jar'
  mirror 'http://ftp.gnu.org/gnu/kawa/kawa-1.11.jar'
  md5 'eee96e13a329513a2f705ee03bacef63'
  head 'svn://sourceware.org/svn/kawa/trunk'

  def script
<<-EOS
#!/bin/sh
# Run Kawa Scheme.

# Add Kawa jar to CLASSPATH.
KAWA="${CLASSPATH:+$CLASSPATH:}#{prefix}/#{name}.jar"

exec java -cp "$KAWA" kawa.repl "$@"
EOS
  end

  def install
    prefix.install "kawa-#{version}.jar" => "kawa.jar"
    (bin+'kawa').write script
  end
end
