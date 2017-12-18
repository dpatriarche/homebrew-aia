class OrthancWebviewer < Formula
  desc "Plugin to extend Orthanc with a Web viewer of medical images."
  homepage "https://www.orthanc-server.com/static.php?page=web-viewer"
  version "2.3"
  url "https://www.orthanc-server.com/downloads/get.php?path=/plugin-webviewer/OrthancWebViewer-2.3.tar.gz"
  sha256 "e9f8b89fb2a63373cccd55267680a953ec49073872dbb8747bc662b4d7955c5e"

  depends_on "doxygen" => :build
  depends_on "cmake" => :build

  def install
    mkdir "build" do
      args = %W[
        -DSTATIC_BUILD=ON
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_INSTALL_PREFIX=#{prefix}
      ]
      system "cmake", *args, ".."
      system "make", "install"
    end
  end

  def caveats; <<-EOS.undent
    For more information about configuring and running Orthanc refer to the Orthanc Book:
      http://book.orthanc-server.com

    This plugin is installed under:
      /usr/local/share/orthanc/plugins/

    You must add this plugin to Orthanc's config file at:
      #{var}/orthanc/config.json
    EOS
  end

  test do
    # TODO
  end
end
