require 'formula'

class Avfs <Formula
  url 'http://downloads.sourceforge.net/project/avf/avfs/0.9.8/avfs-0.9.8.tar.bz2'
  md5 '5281b990251c8c3a15366ad40e4818db'
  homepage 'http://avf.sourceforge.net/'

  depends_on 'fuse' => :pkgconfig

  def patches
    DATA
  end

  def install
    ENV.j1
    system "./configure", "--disable-debug", "--disable-dependency-tracking", "--prefix=#{prefix}", "--enable-fuse"
    system "make install"
  end
end

__END__
diff -urN a/configure b/configure
--- a/configure	2010-07-26 01:51:29.000000000 +0200
+++ b/configure	2010-07-26 02:00:46.000000000 +0200
@@ -25144,7 +25144,7 @@
     FUSELIBS="-lfuse"
 
     install_fuse=yes
-    install_scriptcomps="$install_scriptcomps mountavfs umountavfs"
+    install_scriptcomps="$install_scriptcomps mount_avfs umount_avfs"
   else
     fuse_build=no
   fi
diff -urN a/scripts/Makefile.in b/scripts/Makefile.in
--- a/scripts/Makefile.in	2010-07-26 01:51:29.000000000 +0200
+++ b/scripts/Makefile.in	2010-07-26 01:59:59.000000000 +0200
@@ -241,7 +241,7 @@
 i_codadev1 = $(i_devdir)/cfs1
 i_emacsstart = $(sysconfdir)/emacs/site-start.d
 #################
-EXTRA_DIST = avfscoda.csh avfscoda.sh avfscoda.el davpass ftppass mountavfs umountavfs
+EXTRA_DIST = avfscoda.csh avfscoda.sh avfscoda.el davpass ftppass mount_avfs umount_avfs
 bin_SCRIPTS = ftppass davpass @install_scriptcomps@
 EXTRA_SCRIPTS = avfs-config
 @INSTALL_AVFSCODA_TRUE@@INSTALL_EMACS_TRUE@emacsscriptdir = $(i_emacsstart)
diff -urN a/scripts/mount_avfs b/scripts/mount_avfs
--- a/scripts/mount_avfs	1970-01-01 01:00:00.000000000 +0100
+++ b/scripts/mount_avfs	2010-07-26 01:56:01.000000000 +0200
@@ -0,0 +1,16 @@
+#!/bin/sh
+# mount_avfs -- program to mount avfs file system
+# and load avfsd daemon.
+# companion program to umount_avfs
+# will check to see if avfs is mounted and then
+# load the avfsd daemon which will mount avfs.
+# last updated 20051201
+
+# suggested use: in a login script or wm startup routine
+
+MntDir="${HOME}/.avfs"
+/sbin/mount | egrep -q "^avfsd[^[:space:]]* on $MntDir" || {
+	avfsd "$MntDir"
+	sleep 1
+	echo "1" >"$MntDir/#avfsstat/symlink_rewrite"
+}
diff -urN a/scripts/mountavfs b/scripts/mountavfs
--- a/scripts/mountavfs	2010-07-26 01:51:29.000000000 +0200
+++ b/scripts/mountavfs	1970-01-01 01:00:00.000000000 +0100
@@ -1,17 +0,0 @@
-#!/bin/sh
-# mountavfs -- program to mount avfs file system
-# and load avfsd daemon.
-# companion program to umountavfs
-# will check to see if avfs is mounted and then
-# load the avfsd daemon which will mount avfs.
-# last updated 20051201
-
-# suggested use: in a login script or wm startup routine
-
-MntDir=${HOME}/.avfs
-grep -q "avfsd ${MntDir}" /proc/mounts || {
-   echo Mounting AVFS on $MntDir...
-   avfsd $MntDir
-   echo "1" >"$MntDir/#avfsstat/symlink_rewrite"
-}
-
diff -urN a/scripts/umount_avfs b/scripts/umount_avfs
--- a/scripts/umount_avfs	1970-01-01 01:00:00.000000000 +0100
+++ b/scripts/umount_avfs	2010-07-26 01:59:14.000000000 +0200
@@ -0,0 +1,14 @@
+#!/bin/sh
+# umount_avfs -- program to unmount avfs file system
+# and unload avfsd daemon.
+# companion program to mount_avfs
+# will check to see if avfsd is mounted and then
+# unmount using fusermount.
+# last updated 20051201
+
+# suggested use: in a logout script or wm exit routine
+
+MntDir="${HOME}/.avfs"
+/sbin/mount | egrep -q "^avfsd[^[:space:]]* on $MntDir" && {
+	umount "$MntDir"
+}
diff -urN a/scripts/umountavfs b/scripts/umountavfs
--- a/scripts/umountavfs	2010-07-26 01:51:29.000000000 +0200
+++ b/scripts/umountavfs	1970-01-01 01:00:00.000000000 +0100
@@ -1,16 +0,0 @@
-#!/bin/sh
-# umountavfs -- program to unmount avfs file system
-# and unload avfsd daemon.
-# companion program to mountavfs
-# will check to see if avfsd is mounted and then
-# unmount using fusermount.
-# last updated 20051201
-
-# suggested use: in a logout script or wm exit routine
-
-MntDir=${HOME}/.avfs
-grep -q "avfsd ${MntDir}" /proc/mounts && {
-   echo unMounting AVFS on $MntDir...
-   fusermount -u $MntDir
-}
-
