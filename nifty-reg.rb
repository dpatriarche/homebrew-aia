require "formula"

class NiftyReg < Formula
  desc "Nifty-reg image registration program"
  homepage "http://niftyreg.sourceforge.net"
  url "http://downloads.sourceforge.net/project/niftyreg/nifty_reg-1.3.9/nifty_reg-1.3.9.tar.gz"
  version "1.3.9"
  sha256 "34dfeae2afe86d736e196da573484acc5bf5ad804f8675b9387cd34074da691f"

  depends_on "libpng"
  depends_on "cmake" => :build

  def install
    system "cmake", "-D", "CMAKE_BUILD_TYPE=Release", "."
    system "make", "install"
  end
end
