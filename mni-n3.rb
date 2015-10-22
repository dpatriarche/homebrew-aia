require 'formula'

class MniN3 < Formula
  homepage 'http://en.wikibooks.org/wiki/MINC/Tools/N3'
  url 'http://packages.bic.mni.mcgill.ca/tgz/N3-1.12.0.tar.gz'
  version '1.12.0'
  sha1 '75b05f98b026e5c0c45ea8bcdcfb56b0b8d9e2b4'

  depends_on 'minc'
  depends_on 'netcdf'
  depends_on 'mni-ebtks'
  depends_on 'hdf5'

  depends_on 'gcc' => :build

  depends_on :autoconf => :build
  depends_on :automake => :build
  depends_on :libtool => :build

  def install
    system "autoreconf", "--force", "--install"
    system "./configure", "CC=/usr/local/bin/gcc-5", "CXX=/usr/local/bin/g++-5", "--with-minc2", "--with-build-path=/usr/local", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make install"
  end
end
