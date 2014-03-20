require 'formula'

class Ebtks < Formula
  homepage 'http://en.wikibooks.org/wiki/MINC/Tools'
  url 'http://packages.bic.mni.mcgill.ca/tgz/ebtks-1.6.4.tar.gz'
  sha1 '28e793427ca22b686b9a0d6baba86fcd8263938f'

  depends_on :automake
  depends_on :libtool

  def install
    system "autoreconf", "--force", "--install"
    system "./configure", "CXX=g++", "--prefix=#{prefix}", "--disable-dependency-tracking"
    # Patch a compile error
    system "sed -e 's/static _errorCount = 100;/static int _errorCount = 100;/' -e 's/int operator/inline int operator/' include/Complex.h > Complex.h.tmp && mv Complex.h.tmp include/Complex.h"
    system "make install"
  end
end
