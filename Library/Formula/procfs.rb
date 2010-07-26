require 'formula'

class Procfs <Formula
  url 'http://distfiles.macports.org/procfs/procfs-2.0.tar.bz2'
  md5 'f86caba1b5f028f9f232b039b2889c8f'
  head 'http://macfuse.googlecode.com/svn/trunk/filesystems/procfs/'
  homepage 'http://osxbook.com/book/bonus/chapter11/procfs/'

  depends_on 'pcre'
  depends_on 'fuse' => :pkgconfig

  def patches
    DATA
  end

  def install
    system "make"
    # system "make install"
  end
end
__END__
--- a/Makefile	2007-12-12 20:04:30.000000000 +0100
+++ b/Makefile	2010-07-26 00:03:51.000000000 +0200
@@ -5,17 +5,16 @@
 #
 # http://code.google.com/p/macfuse/
 
-CXXFLAGS=-D_FILE_OFFSET_BITS=64 -D__FreeBSD__=10 -O -g -arch i386 -arch ppc -isysroot /Developer/SDKs/MacOSX10.5.sdk
-LDFLAGS=-L/usr/local/lib -lfuse -framework Carbon -framework IOKit -framework ApplicationServices -framework Accelerate -framework OpenGL -weak-lproc
+CXXFLAGS=$(shell pkg-config --cflags fuse)
+LDFLAGS=$(shell pkg-config --libs fuse) -framework Carbon -framework IOKit -framework ApplicationServices -framework Accelerate -framework OpenGL -weak-lproc
 SEQUENCEGRAB_LDFLAGS=-framework AudioUnit -framework Cocoa -framework CoreAudioKit -framework Foundation -framework QuartzCore -framework QuickTime -framework QuartzCore
 
 # Configure this depending on where you installed pcrecpp
 # http://www.pcre.org
 #
-PCRECPP_PREFIX=/usr/local
 
-PCRECPP_CXXFLAGS=-I$(PCRECPP_PREFIX)/include
-PCRECPP_LDFLAGS=-arch i386 -arch ppc $(PCRECPP_PREFIX)/lib/libpcrecpp.a $(PCRECPP_PREFIX)/lib/libpcre.a
+PCRECPP_CXXFLAGS=$(shell pcre-config --cflags)
+PCRECPP_LDFLAGS=$(shell pcre-config --libs-cpp)
 
 all: procfs
 
--- a/procfs.cc	2008-12-18 07:14:17.000000000 +0100
+++ b/procfs.cc	2010-07-26 00:51:07.000000000 +0200
@@ -92,15 +92,15 @@
 {
     kern_return_t      kr;
     IOItemCount        isize = sms_gStructureInputSize;
-    IOByteCount        osize = sms_gStructureOutputSize;
+    size_t             osize = sms_gStructureOutputSize;
     MotionSensorData_t idata;
 
-    kr = IOConnectMethodStructureIStructureO(motionsensor_port,
-                                             sms_gIndex,
-                                             isize,
-                                             &osize,
-                                             &idata,
-                                             odata);
+    kr = IOConnectCallStructMethod(motionsensor_port,
+                                   sms_gIndex,
+                                   &idata,
+                                   isize,
+                                   odata,
+                                   &osize);
     return kr;
 }
 
@@ -1223,16 +1223,13 @@
     }
     char *whandler = NULL;
     if ((whandler = getenv("MACFUSE_PROCFS_WHANDLER")) == NULL) {
-        goto bail;
+        return 0;
     }
     int npid = vfork();
     if (npid == 0) {
         execl(whandler, whandler, argv[0], NULL);
         return 0;
     }
-
-bail:
-    return 0;
 }
 
 OPEN_HANDLER(proc__windows__screenshots__window)
@@ -1947,6 +1944,7 @@
         if (kr == KERN_SUCCESS) {
             CFDataRef xml = CFPropertyListCreateXMLData(kCFAllocatorDefault,
                                 (CFPropertyListRef)optionsDict);
+            const UInt8 *tmpbuf = CFDataGetBytePtr(xml);
 
             int len = CFDataGetLength(xml);
             if (len < 0) {
@@ -1954,8 +1952,6 @@
                 goto done;
             }
 
-            const UInt8 *tmpbuf = CFDataGetBytePtr(xml);
-   
             if (offset < len) {
                 if (offset + size > len)
                     size = len - offset;
@@ -2183,15 +2179,15 @@
     if (strcmp(whichfile, "lightsensor") == 0) {
         unsigned int  gIndex = 0;
         IOItemCount   scalarInputCount = 0;
-        IOItemCount   scalarOutputCount = 2;
+        size_t        scalarOutputCount = 2;
         SInt32 left = 0, right = 0;
         if (lightsensor_port == 0) {
             len = snprintf(tmpbuf, 4096, "not available\n");
             goto gotdata;
         }
-        kr = IOConnectMethodScalarIScalarO(lightsensor_port, gIndex,
-                                           scalarInputCount, scalarOutputCount,
-                                           &left, &right);
+        kr = IOConnectCallStructMethod(lightsensor_port, gIndex,
+                                       &left, scalarInputCount,
+                                       &right, &scalarOutputCount);
         if (kr == KERN_SUCCESS) {
             len = snprintf(tmpbuf, 4096, "%ld %ld\n", left, right);
         } else if (kr == kIOReturnBusy) {
