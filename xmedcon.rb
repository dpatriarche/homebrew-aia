require 'formula'

class Xmedcon < Formula
  homepage 'http://xmedcon.sourceforge.net'
  url 'http://downloads.sourceforge.net/project/xmedcon/XMedCon-Source/0.13.0/xmedcon-0.13.0.tar.bz2'
  sha1 'ab252b50ad9c99f9f8936e6c90f704c122f72a8e'

  depends_on 'glib'
  depends_on 'gtk+'
  depends_on 'gdk-pixbuf'
  depends_on 'pkg-config'

  depends_on :autoconf => :build
  depends_on :automake => :build
  depends_on :libtool => :build

  def install
    system "autoreconf", "--force", "--install"
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make install"
  end
end
