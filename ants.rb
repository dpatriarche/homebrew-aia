require "formula"

class Ants < Formula
  desc "Advanced Normalization Tools"
  homepage "https://stnava.github.io/ANTs/"
  url "https://github.com/ANTsX/ANTs/archive/v2.3.1.tar.gz"
  version "2.3.1"
  sha256 "c0680feab0ebb85c8cd6685043126666929b35e1cf387a5cc1d3a2d7169bddd3"

  bottle :unneeded

  depends_on "doxygen" => :build
  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "-DCMAKE_BUILD_TYPE=Release", "-DCMAKE_INSTALL_PREFIX=" + prefix, "-DRUN_LONG_TESTS=off", ".."
      system "make", "-j", "4"
      bin.install "bin/N4BiasFieldCorrection"
    end
  end
end
