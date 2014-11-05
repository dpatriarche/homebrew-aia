require 'formula'

class MniEbtks < Formula
  homepage 'http://en.wikibooks.org/wiki/MINC/Tools'
  #url 'http://packages.bic.mni.mcgill.ca/tgz/ebtks-1.6.4.tar.gz'
  #sha1 '28e793427ca22b686b9a0d6baba86fcd8263938f'
  head 'https://github.com/BIC-MNI/EBTKS', :using => :git

  depends_on 'gcc49' => :build

  depends_on :autoconf => :build
  depends_on :automake => :build
  depends_on :libtool => :build

  patch :DATA

  def install
    system "autoreconf", "--force", "--install"
    system "./configure", "CC=/usr/local/bin/gcc-4.9", "CXX=/usr/local/bin/g++-4.9", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make install"
  end
end

__END__
diff --git a/configure.ac b/configure.ac
index 5a9fd49..96a91d9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -3,7 +3,7 @@ dnl Process this file with autoconf to produce a configure script.
 AC_INIT([ebtks],[1.6.4],[Andrew Janke <a.janke@gmail.com>])
 AC_CONFIG_SRCDIR([src/FileIO.cc])
 
-AM_INIT_AUTOMAKE
+AM_INIT_AUTOMAKE([subdir-objects])
 
 AC_CONFIG_HEADERS([config.h])
 
diff --git a/include/Complex.h b/include/Complex.h
index f8570f5..b6b0289 100644
--- a/include/Complex.h
+++ b/include/Complex.h
@@ -29,7 +29,7 @@ $State: Exp $
   typedef complex dcomplex;
 #endif
 
-static _errorCount = 100;
+static int _errorCount = 100;
 
 int operator < (const dcomplex&, const dcomplex&) {
   if (_errorCount) {

diff --git a/templates/MatrixSupport.cc b/templates/MatrixSupport.cc
index a787047..23beba5 100644
--- a/templates/MatrixSupport.cc
+++ b/templates/MatrixSupport.cc
@@ -21,7 +21,8 @@ $State: Exp $
 
 #ifdef HAVE_MALLOC_H
 #include <malloc.h>
-#endif 
+#endif
+#include <stdlib.h>
 
 #include <math.h>
 #include <stdio.h>

diff --git a/include/Complex.h b/include/Complex.h
index b6b0289..3bb6c00 100644
--- a/include/Complex.h
+++ b/include/Complex.h
@@ -31,7 +31,7 @@ $State: Exp $
 
 static int _errorCount = 100;
 
-int operator < (const dcomplex&, const dcomplex&) {
+inline int operator < (const dcomplex&, const dcomplex&) {
   if (_errorCount) {
     cerr << "Comparison of dcomplex numbers undefined" << endl;
     _errorCount--;
@@ -39,7 +39,7 @@ int operator < (const dcomplex&, const dcomplex&) {
   return 0;
 }
 
-int operator <= (const dcomplex&, const dcomplex&) {
+inline int operator <= (const dcomplex&, const dcomplex&) {
   if (_errorCount) {
     cerr << "Comparison of dcomplex numbers undefined" << endl;
     _errorCount--;
@@ -47,7 +47,7 @@ int operator <= (const dcomplex&, const dcomplex&) {
   return 0;
 }
 
-int operator > (const dcomplex&, const dcomplex&) {
+inline int operator > (const dcomplex&, const dcomplex&) {
   if (_errorCount) {
     cerr << "Comparison of dcomplex numbers undefined" << endl;
     _errorCount--;
@@ -55,7 +55,7 @@ int operator > (const dcomplex&, const dcomplex&) {
   return 0;
 }
 
-int operator >= (const dcomplex&, const dcomplex&) {
+inline int operator >= (const dcomplex&, const dcomplex&) {
   if (_errorCount) {
     cerr << "Comparison of dcomplex numbers undefined" << endl;
     _errorCount--;
