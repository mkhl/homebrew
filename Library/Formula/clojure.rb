require 'formula'

class Clojure < Formula
  url 'http://repo1.maven.org/maven2/org/clojure/clojure/1.4.0/clojure-1.4.0.zip'
  md5 'db17baaea5bc90687c6293260499cca8'
  head 'https://github.com/clojure/clojure.git'
  homepage 'http://clojure.org/'

  def script; <<-EOS.undent
    #!/bin/sh
    # Run Clojure.

    # Add Clojure jar to CLASSPATH.
    CLOJURE="${CLASSPATH:+$CLASSPATH:}#{prefix}/clojure-#{version}.jar"

    exec java -cp "$CLOJURE" clojure.main "$@"
    EOS
  end

  def install
    system "ant" if ARGV.build_head?
    prefix.install 'clojure-1.4.0.jar'
    (prefix+'clojure-1.4.0.jar').chmod(0644) # otherwise it's 0600
    (prefix+'classes').mkpath
    (bin+'clj').write script
  end

  def caveats; <<-EOS.undent
    If you `brew install repl` then you may find this wrapper script from
    MacPorts useful:
      http://trac.macports.org/browser/trunk/dports/lang/clojure/files/clj-rlwrap.sh?format=txt
    EOS
  end

  def test
    system "#{bin}/clj", "-e", '(println "Hello World")'
  end
end
