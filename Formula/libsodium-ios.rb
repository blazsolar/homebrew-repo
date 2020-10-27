class LibsodiumIos < Formula
  desc "NaCl networking and cryptography library"
  homepage "https://libsodium.org/"
  url "https://download.libsodium.org/libsodium/releases/libsodium-1.0.18.tar.gz"
  sha256 "6f504490b342a4f8a4c4a02fc9b866cbef8622d5df4e5452b46be121e46636c1"
  license "ISC"
  revision 1

  livecheck do
    url "https://download.libsodium.org/libsodium/releases/"
    regex(/href=.*?libsodium[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    cellar :any
    sha256 "db372521cd0b1861a5b578bee22426f3a1f4f7cb3c382be1f842da4715dc65bd" => :catalina
    sha256 "55245bfcf6654b0914d3f7459b99a08c54ef2560587bf583a1c1aff4cfc81f28" => :mojave
    sha256 "fc972755eb60f4221d7b32e58fc0f94e99b913fefefc84c4c76dc4bca1c5c445" => :high_sierra
  end

  head do
    url "https://github.com/jedisct1/libsodium.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  def install
    system "echo", "SDK: Test"
    system "export", "XCODEDIR=/Applications/Xcode.app/Contents/Developer"
    system "echo", "SDK: Test 2"
    system "export", "BASEDIR=\"${XCODEDIR}/Platforms/iPhoneOS.platform/Developer\""
    system "export", "PATH=\"${BASEDIR}/usr/bin:$BASEDIR/usr/sbin:$PATH\""
    system "export", "SDK=\"${BASEDIR}/SDKs/iPhoneOS.sdk\""
    system "echo", "SDK: ${SDK}"

    system "./autogen.sh" if build.head?

    ## 64-bit iOS
    system "export" "CFLAGS=\"-fembed-bitcode -O2 -arch arm64 -isysroot ${SDK} -mios-version-min=9.0.0\""
    system "export", "LDFLAGS=\"-fembed-bitcode -arch arm64 -isysroot ${SDK} -mios-version-min=9.0.0\""

    system "make distclean >/dev/null 2>&1"
    system "./configure", "--host=arm-apple-darwin10", "--prefix=#{prefix}/tmp/ios64"
    system "make" "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <assert.h>
      #include <sodium.h>

      int main()
      {
        assert(sodium_init() != -1);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}",
                   "-lsodium", "-o", "test"
    system "./test"
  end
end