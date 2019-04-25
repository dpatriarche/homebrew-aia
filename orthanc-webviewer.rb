class OrthancWebviewer < Formula
  desc "Plugin to extend Orthanc with a Web viewer of medical images."
  homepage "https://www.orthanc-server.com/static.php?page=web-viewer"
  version "2.5"
  url "https://www.orthanc-server.com/downloads/get.php?path=/plugin-webviewer/OrthancWebViewer-2.5.tar.gz"
  sha256 "c2957cf74f4ef8f724c83f613948ca55261c7bc0e6ca65b6f172bcffdbf3c6bf"

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

  def caveats
    <<~EOS
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
