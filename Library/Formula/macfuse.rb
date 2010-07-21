require 'formula'

class Macfuse <Formula
  url 'http://distfiles.macports.org/macfuse/macfuse-2.0.3.tar.bz2'
  md5 '97ab76bbade128828596aca878c6c475'
  homepage 'http://code.google.com/p/macfuse/'

  def install
    inreplace 'macfuse_buildtool.sh' do |s|
      # s.gsub! '/usr/local', prefix
      s.gsub! '@@WORKPATH@@', '/tmp'
      s.gsub! '@@DESTPATH@@', '$ms_macfuse_out/pkgroot/'
    end
    # inreplace 'sdk-objc/MacFUSE.xcodeproj/project.pbxproj', '/usr/local', prefix
    # inreplace '10.5/libfuse/fuse-2.7.3-macosx.patch', '@@PREFIX@@', prefix
    # inreplace '10.6/libfuse/fuse-2.7.3-macosx.patch', '@@PREFIX@@', prefix
    system './macfuse_buildtool.sh', '-t', 'smalldist'
    system 'false'
  end

  def patch
    safe_system '/bin/cp', '-R', '10.5', '10.6'
    super
  end

  def patches
    macports_patches 'fuse', %w[
      patch-10.5-to-10.6.diff
      patch-macfuse_buildtool.sh.diff
      patch-sdk-objc_GMUserFileSystem.m.diff
      patch-sdk-objc_MacFuse.xcodeproj.diff
      patch-10.5_fusefs_fusefs.xcodeproj_project.pbxproj.diff
    ]
    # patch-10.5_libfuse_fuse-2.7.3-macosx.patch.diff
    # patch-10.6_libfuse_fuse-2.7.3-macosx.patch.diff
  end

  def macports_patches(group, files)
    { :p0 => files.collect { |file| macports_patch_url(group, file) } }
  end

  def macports_patch_url(group, file)
    template = 'http://svn.macports.org/repository/macports/trunk/dports/%s/%s/files/%s'
    template % [group, name, file]
  end
end
