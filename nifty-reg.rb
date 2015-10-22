require 'formula'

class NiftyReg < Formula
  homepage 'http://niftyreg.sourceforge.net'
  url 'http://downloads.sourceforge.net/project/niftyreg/nifty_reg-1.3.9/nifty_reg-1.3.9.tar.gz'
  version '1.3.9'
  sha1 '0639d4ccf0f701f02da25a92d34ee80cdc3634a9'

  depends_on 'libpng'
  depends_on 'cmake' => :build

  def install
    system "cmake ."
    system "make"
    system "make install"
  end
end
