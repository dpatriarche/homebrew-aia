require 'formula'

class MniEbtks < Formula
  homepage 'http://en.wikibooks.org/wiki/MINC/Tools'
  url 'http://packages.bic.mni.mcgill.ca/tgz/ebtks-1.6.4.tar.gz'
  sha1 '28e793427ca22b686b9a0d6baba86fcd8263938f'

  depends_on 'apple-gcc42' => :build

  depends_on :autoconf => :build
  depends_on :automake => :build
  depends_on :libtool => :build

  def install
    # Add an option into configure.ac so that object files live in the same subdirectories as the source files, rather than all being dumped into the root folder.
    system "sed -e 's/AM_INIT_AUTOMAKE/AM_INIT_AUTOMAKE([subdir-objects])/' configure.ac > configure.ac.tmp && mv configure.ac.tmp configure.ac"

    # Fix compile errors in include/Complex.h
    system "sed -e 's/static _errorCount = 100;/static int _errorCount = 100;/' -e 's/int operator/inline int operator/' include/Complex.h > Complex.h.tmp && mv Complex.h.tmp include/Complex.h"

    # Fix a compile error in src/FileIO.cc
    system "echo \"44c44
<     return *_ipipe;
---
>     return _ipipe;\" > src/FileIO.cc.patch"
    system "patch src/FileIO.cc src/FileIO.cc.patch"
    system "rm src/FileIO.cc.patch"

    system "autoreconf", "--force", "--install"
    system "./configure", "CC=/usr/local/bin/gcc-4.2", "CXX=/usr/local/bin/g++-4.2", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make install"
  end
end
