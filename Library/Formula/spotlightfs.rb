require 'formula'

class FuseSupport <Formula
  url 'http://macfuse.googlecode.com/svn/tags/macfuse-2.0/filesystems-objc/Support/'
  head 'http://macfuse.googlecode.com/svn/trunk/filesystems-objc/Support/'
  version '2.0'
end

class Spotlightfs <Formula
  url 'http://macfuse.googlecode.com/svn/tags/macfuse-2.0/filesystems-objc/SpotlightFS/'
  head 'http://macfuse.googlecode.com/svn/trunk/filesystems-objc/SpotlightFS/'
  homepage 'http://code.google.com/p/macfuse/'
  version '2.0'

  depends_on 'fuse' => :pkgconfig

  def patches
    DATA
  end

  def install
    support = Pathname.pwd+'Support'
    support.mkpath
    FuseSupport.new('Support').brew { support.install Dir["NSError+POSIX.*"] }
    system "xcodebuild"
    prefix.install "build/Release/SpotlightFS.app"
  end
end
__END__
--- a/SpotlightFS.xcodeproj/project.pbxproj	2008-01-14 00:08:32.000000000 +0100
+++ b/SpotlightFS.xcodeproj/project.pbxproj	2010-07-26 03:02:25.000000000 +0200
@@ -32,8 +32,8 @@
 		29B97324FDCFA39411CA2CEA /* AppKit.framework */ = {isa = PBXFileReference; lastKnownFileType = wrapper.framework; name = AppKit.framework; path = /System/Library/Frameworks/AppKit.framework; sourceTree = "<absolute>"; };
 		29B97325FDCFA39411CA2CEA /* Foundation.framework */ = {isa = PBXFileReference; lastKnownFileType = wrapper.framework; name = Foundation.framework; path = /System/Library/Frameworks/Foundation.framework; sourceTree = "<absolute>"; };
 		32CA4F630368D1EE00C91783 /* SpotlightFS_Prefix.pch */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.h; path = SpotlightFS_Prefix.pch; sourceTree = "<group>"; };
-		8B93BE9A0D3ACCEF00466F25 /* NSError+POSIX.h */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.h; name = "NSError+POSIX.h"; path = "../Support/NSError+POSIX.h"; sourceTree = SOURCE_ROOT; };
-		8B93BE9B0D3ACCEF00466F25 /* NSError+POSIX.m */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.objc; name = "NSError+POSIX.m"; path = "../Support/NSError+POSIX.m"; sourceTree = SOURCE_ROOT; };
+		8B93BE9A0D3ACCEF00466F25 /* NSError+POSIX.h */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.h; name = "NSError+POSIX.h"; path = "Support/NSError+POSIX.h"; sourceTree = SOURCE_ROOT; };
+		8B93BE9B0D3ACCEF00466F25 /* NSError+POSIX.m */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.c.objc; name = "NSError+POSIX.m"; path = "Support/NSError+POSIX.m"; sourceTree = SOURCE_ROOT; };
 		8D1107310486CEB800E47090 /* Info.plist */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = text.plist; path = Info.plist; sourceTree = "<group>"; };
 		8D1107320486CEB800E47090 /* SpotlightFS.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = SpotlightFS.app; sourceTree = BUILT_PRODUCTS_DIR; };
 		F927CCFF0B6405DC00AF272E /* DynamicFolderBlue.icns */ = {isa = PBXFileReference; lastKnownFileType = image.icns; path = DynamicFolderBlue.icns; sourceTree = "<group>"; };
@@ -270,36 +270,28 @@
 		C01FCF4F08A954540054247B /* Debug */ = {
 			isa = XCBuildConfiguration;
 			buildSettings = {
-				ARCHS = (
-					i386,
-					ppc,
-				);
 				GCC_C_LANGUAGE_STANDARD = c99;
 				GCC_ENABLE_OBJC_EXCEPTIONS = YES;
 				GCC_WARN_ABOUT_RETURN_TYPE = YES;
 				GCC_WARN_UNUSED_VARIABLE = YES;
 				HEADER_SEARCH_PATHS = "";
+				ONLY_ACTIVE_ARCH = YES;
 				OTHER_CFLAGS = "";
 				PREBINDING = NO;
-				SDKROOT = /Developer/SDKs/MacOSX10.4u.sdk;
 			};
 			name = Debug;
 		};
 		C01FCF5008A954540054247B /* Release */ = {
 			isa = XCBuildConfiguration;
 			buildSettings = {
-				ARCHS = (
-					i386,
-					ppc,
-				);
 				GCC_C_LANGUAGE_STANDARD = c99;
 				GCC_ENABLE_OBJC_EXCEPTIONS = YES;
 				GCC_WARN_ABOUT_RETURN_TYPE = YES;
 				GCC_WARN_UNUSED_VARIABLE = YES;
 				HEADER_SEARCH_PATHS = "";
+				ONLY_ACTIVE_ARCH = YES;
 				OTHER_CFLAGS = "";
 				PREBINDING = NO;
-				SDKROOT = /Developer/SDKs/MacOSX10.4u.sdk;
 			};
 			name = Release;
 		};
