require "formula"

class NiftyReg < Formula
  # NiftyReg installation instructions: http://cmictig.cs.ucl.ac.uk/wiki/index.php/NiftyReg_install
  desc "Nifty-reg image registration program"
  homepage "http://niftyreg.sourceforge.net"
  head "https://sourceforge.net/code-snapshots/git/n/ni/niftyreg/git.git"
  url "https://sourceforge.net/code-snapshots/git/n/ni/niftyreg/git.git/niftyreg-git-88b369becb6bdbda22ea96a0bef2b83bee85b219.zip"
  version "1.5.41"
  sha256 "8906a1f5082501cc1f219ddf6149ef17fe45563a51523dc314a016a8fc7de83e"

  depends_on "libpng"
  depends_on "doxygen" => :build
  depends_on "cmake" => :build
  depends_on "gcc5" => :build

  def install
    mkdir "build" do
      system "cmake", "-DCMAKE_BUILD_TYPE=Release", "-DCMAKE_INSTALL_PREFIX=" + prefix, "-DCMAKE_C_COMPILER=gcc-5", "-DCMAKE_CXX_COMPILER=g++-5", ".."
      system "make", "install"
    end
  end
end
