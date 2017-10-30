class X8664UnknownLinuxGnuBinutils < Formula
  TARGET = "x86_64_unknown_linux_gnu"
  desc "FSF Binutils for cross-compiling #{TARGET}"
  homepage "https://www.gnu.org/software/binutils/binutils.html"
  url "https://ftpmirror.gnu.org/binutils/binutils-2.25.tar.gz"
  mirror "https://ftp.gnu.org/gnu/binutils/binutils-2.25.tar.gz"
  version "2.25"
  sha256 "cccf377168b41a52a76f46df18feb8f7285654b3c1bd69fc8265cb0fc6902f2d"

  # Build-only dependencies
  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    mkdir "build" do
      system "../configure", "--target=#{TARGET}",
                             "--prefix=#{prefix}",
                             "--infodir=#{info}",
                             "--mandir=#{man}",
                             "--with-sysroot",
                             "--disable-nls",
                             "--disable-werror"
      system "make"
      system "make", "install"
    end

    info.rmtree # info files conflict with native binutils
  end

  test do
     assert_match "main", shell_output("#{bin}/#{TARGET}-gnm #{bin}/#{TARGET}-gnm")
  end
end
