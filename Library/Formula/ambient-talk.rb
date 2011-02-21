require 'formula'

class AmbientTalk < Formula
  homepage 'http://soft.vub.ac.be/amop/'
  url 'http://ambienttalk.googlecode.com/files/at2dist231210.zip'
  md5 '299bc3251f76a91d77917d9a1af64976'

  def script
<<-EOS
#!/bin/sh
# Run Ambient Talk.

# Define AT_HOME
: ${AT_HOME:="#{libexec}"}
export AT_HOME

exec "$AT_HOME/iat" "$@"
EOS
  end

  def install
    libexec.install ['ambienttalk2.jar', 'atlib', 'jlib', 'iat']
    (libexec+'iat').chmod 0555
    (bin+'iat').write script
  end
end
