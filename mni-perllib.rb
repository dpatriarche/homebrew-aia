require 'formula'

class MniPerllib < Formula
  homepage 'http://en.wikibooks.org/wiki/MINC/Tools'
  url 'http://packages.bic.mni.mcgill.ca/tgz/mni_perllib-0.08.tar.gz'
  version '0.08'
  sha1 '20c76d7e7d229533d1e3e68d02440fa189ae6daa'

  def install
    #system "autoreconf", "--force", "--install"
    #system "./configure", "--with-minc2", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "echo | perl Makefile.PL INSTALL_BASE=/usr/local/mni"
    system "make install"
  end
end
