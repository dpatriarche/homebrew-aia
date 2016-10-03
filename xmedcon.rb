require 'formula'

class Xmedcon < Formula
  homepage 'http://xmedcon.sourceforge.net'
  url 'http://downloads.sourceforge.net/project/xmedcon/XMedCon-Source/0.13.0/xmedcon-0.13.0.tar.bz2'
  version '0.13.0'
  sha256 '66f402551c2c08f9779c6eb233a03f4f12c62c5b8b879f42058f0c320a71fd21'

  depends_on 'glib'
  depends_on 'gtk+'
  depends_on 'gdk-pixbuf'
  depends_on 'pkg-config'
  depends_on 'libpng'

  depends_on 'autoconf' => :build
  depends_on 'automake' => :build
  depends_on 'libtool' => :build

  def install
    system "autoreconf", "--force", "--install"
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make", "install"
  end
end
