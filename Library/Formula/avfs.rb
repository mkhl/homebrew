require 'formula'

class Avfs <Formula
  url 'http://downloads.sourceforge.net/project/avf/avfs/0.9.8/avfs-0.9.8.tar.bz2'
  md5 '5281b990251c8c3a15366ad40e4818db'
  homepage 'http://avf.sourceforge.net/'

  depends_on 'fuse' => :pkgconfig

  def patches
    {:p0 => DATA}
  end

  def install
    ENV.j1
    system "./configure", "--disable-debug", "--disable-dependency-tracking", "--prefix=#{prefix}", "--enable-fuse"
    system "make install"
  end
end

__END__
--- scripts/umountavfs.orig	2005-12-02 10:51:46.000000000 +0100
+++ scripts/umountavfs	2010-07-20 13:44:20.000000000 +0200
@@ -8,9 +8,8 @@
 
 # suggested use: in a logout script or wm exit routine
 
-MntDir=${HOME}/.avfs
-grep -q "avfsd ${MntDir}" /proc/mounts && {
+MntDir="${HOME}/.avfs"
+/sbin/mount | egrep -q "^avfsd[^[:space:]]* on $MntDir" && {
    echo unMounting AVFS on $MntDir...
-   fusermount -u $MntDir
+   umount "$MntDir"
 }
-
--- scripts/mountavfs.orig	2006-04-05 19:19:09.000000000 +0200
+++ scripts/mountavfs	2010-07-20 13:44:45.000000000 +0200
@@ -8,10 +8,9 @@
 
 # suggested use: in a login script or wm startup routine
 
-MntDir=${HOME}/.avfs
-grep -q "avfsd ${MntDir}" /proc/mounts || {
+MntDir="${HOME}/.avfs"
+/sbin/mount | egrep -q "^avfsd[^[:space:]]* on $MntDir" || {
    echo Mounting AVFS on $MntDir...
-   avfsd $MntDir
+   avfsd "$MntDir"
    echo "1" >"$MntDir/#avfsstat/symlink_rewrite"
 }
-
