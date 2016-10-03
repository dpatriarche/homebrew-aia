require 'formula'

class MniPerllib < Formula
  homepage 'http://en.wikibooks.org/wiki/MINC/Tools'
  url 'http://packages.bic.mni.mcgill.ca/tgz/mni_perllib-0.08.tar.gz'
  version '0.08'
  sha256 'e5dba59674be4ef9144f7805f74f64ce98c10cfdeedddcb7468d9993abd58662'

  def install
    #system "autoreconf", "--force", "--install"
    #system "./configure", "--with-minc2", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "echo | perl Makefile.PL INSTALL_BASE=/usr/local/mni"
    system "make", "install"
  end
end
