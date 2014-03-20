require 'formula'

class N3 < Formula
  homepage 'http://en.wikibooks.org/wiki/MINC/Tools/N3'
  url 'http://packages.bic.mni.mcgill.ca/tgz/N3-1.12.0.tar.gz'
  sha1 '75b05f98b026e5c0c45ea8bcdcfb56b0b8d9e2b4'

  depends_on 'minc'
  depends_on 'netcdf'
  depends_on 'homebrew/science/ebtks'

  depends_on :automake
  depends_on :libtool

  def install
    system "autoreconf", "--force", "--install"
    system "./configure", "--with-minc2", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make install"
  end
end
