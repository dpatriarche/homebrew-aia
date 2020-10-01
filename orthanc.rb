class Orthanc < Formula
  desc "Open-source, lightweight DICOM server"
  homepage "http://orthanc-server.com"
  version "1.6.1"
  url "https://www.orthanc-server.com/downloads/get.php?path=/orthanc/Orthanc-1.6.1.tar.gz"
  sha256 "86f6e1a79bc93f082fd5243dd4daaf5a2ea05fcdf515cf35f100829c5fe5c4df"
  head "https://hg.orthanc-server.com/orthanc/shortlog/default", :branch => "Orthanc-1.6.1"

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

      #--------------------------------------------------------------------------------
      #
      # IMPORTANT: Fix a bug in the version 1.6.1 cmake scripts. The script refers to
      # files libConnectivityChecks.tbd.1.6.1 and libConnectivityChecks.tbd rather
      # than the real names of the file (below).
      #
      contents = File.read("cmake_install.cmake")
      contents.gsub!(/libConnectivityChecks\.tbd\.1\.6\.1/, "libConnectivityChecks.1.6.1.dylib")
      contents.gsub!(/libConnectivityChecks\.tbd/, "libConnectivityChecks.dylib")
      File.open("cmake_install.cmake", 'w') do |out|
        out << contents
      end
      #--------------------------------------------------------------------------------

      system "make", "install"

      (var/"orthanc").mkpath
      unless File.exist? "#{var}/orthanc/config.json"
        system "cp", "../Resources/Configuration.json", "#{var}/orthanc/config.json"
      else
        system "cp", "../Resources/Configuration.json", "#{var}/orthanc/config-ORIG.XXX.json"
      end

    end
  end

  # def post_install
  #   (var/"orthanc").mkpath
  #   unless File.exist? "#{var}/orthanc/config.json"
  #     system "cp", "Resources/Configuration.json", "#{var}/orthanc/config.json"
  #   else
  #     system "cp", "Resources/Configuration.json", "#{var}/orthanc/config-ORIG.json"
  #   end
  # end

  def caveats;
    <<~EOS
    For more information about configuring and running Orthanc refer to the Orthanc Book:
      https://orthanc.chu.ulg.ac.be/book/index.html

    You can configure Orthanc's config file at:
      #{var}/orthanc/config.json

    Orthanc saves its log to:
      #{var}/orthanc/orthanc.log
    EOS
  end

  def plist
    <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>KeepAlive</key>
      <true/>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{prefix}/sbin/Orthanc</string>
        <string>#{var}/orthanc/config.json</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>WorkingDirectory</key>
      <string>#{var}/orthanc</string>
      <key>StandardErrorPath</key>
      <string>#{var}/orthanc/orthanc.log</string>
    </dict>
    </plist>
    EOS
  end

  test do
    # TODO
  end
end
