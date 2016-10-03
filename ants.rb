require "formula"

class Ants < Formula
  desc "Advanced Normalization Tools"
  homepage "https://stnava.github.io/ANTs/"
  url "https://github.com/stnava/ANTs/releases/download/v2.1.0/Yosemite.tar.bz2.zip"
  version "2.1.0"
  sha256 "e44831b24bdc30f32333477618cc6a093e532f1a0c41b2dbb935412b4d884b2f"

  bottle :unneeded

  def install
    system "tar", "-xjf", "Yosemite.tar.bz2", "bin/N4BiasFieldCorrection"
    bin.install "bin/N4BiasFieldCorrection"
  end
end
