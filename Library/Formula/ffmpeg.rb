require 'formula'

def ffplay?
  ARGV.include? '--with-ffplay'
end

class Ffmpeg < Formula
  homepage 'http://ffmpeg.org/'
  url 'http://ffmpeg.org/releases/ffmpeg-0.11.tar.bz2'
  sha1 '1aa3443c20b1c5d132d1fe06de7cc949a7219edd'

  head 'git://git.videolan.org/ffmpeg.git'

  def self.dependencies; {
    'x264'         => ['libx264'],
    'faac'         => ['libfaac'],
    'lame'         => ['libmp3lame'],
    'rtmpdump'     => ['librtmp'],
    'theora'       => ['libtheora'],
    'libvorbis'    => ['libvorbis'],
    'libvpx'       => ['libvpx'],
    'xvid'         => ['libxvid'],
    'libvo-aacenc' => ['libvo-aacenc'],
    'libass'       => ['libass'],
    'schroedinger' => ['libschroedinger'],
    'opencore-amr' => ['libopencore-amrnb', 'libopencore-amrwb']
  }; end

  dependencies.keys.each do |keg|
    depends_on keg => :optional
  end

  depends_on 'sdl' if ffplay?

  def options
    [
      ["--with-tools", "Install additional FFmpeg tools."],
      ["--with-ffplay", "Build ffplay."]
    ]
  end

  def install
    ENV.x11
    args = ["--prefix=#{prefix}",
            "--enable-shared",
            "--enable-gpl",
            "--enable-version3",
            "--enable-nonfree",
            "--enable-hardcoded-tables",
            "--enable-libfreetype",
            "--cc=#{ENV.cc}"]

    self.class.dependencies.each do |keg, libs|
      libs.each do |lib|
        args << "--enable-#{lib}" if Formula.factory(keg).linked_keg.exist?
      end
    end
    args << "--disable-ffplay" unless ffplay?

    # For 32-bit compilation under gcc 4.2, see:
    # http://trac.macports.org/ticket/20938#comment:22
    if MacOS.leopard? or Hardware.is_32_bit?
      ENV.append_to_cflags "-mdynamic-no-pic"
    end

    system "./configure", *args

    if MacOS.prefer_64_bit?
      inreplace 'config.mak' do |s|
        shflags = s.get_make_var 'SHFLAGS'
        if shflags.gsub!(' -Wl,-read_only_relocs,suppress', '')
          s.change_make_var! 'SHFLAGS', shflags
        end
      end
    end

    system "make install"

    if ARGV.include? "--with-tools"
      system "make alltools"
      bin.install Dir['tools/*'].select {|f| File.executable? f}
    end
  end

end
