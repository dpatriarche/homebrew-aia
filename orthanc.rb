class Orthanc < Formula
  desc "Open-source, lightweight DICOM server"
  homepage "http://orthanc-server.com"
  version "1.2.0"
  url "https://bitbucket.org/sjodogne/orthanc/get/Orthanc-1.2.0.zip"
  sha256 "4fa0014bff255cfff80d0913c17a40db406c7853a56696bd20a8da9191b366ad"
  head "https://bitbucket.org/sjodogne/orthanc.git", :branch => "Orthanc-1.2.0"

  depends_on "doxygen" => :build
  depends_on "cmake" => :build
  depends_on "gcc5" => :build

  # -DSTANDALONE_BUILD=ON
  # -DALLOW_DOWNLOADS=ON

  def install
    mkdir "build" do
      args = %W[
        -DSTATIC_BUILD=ON
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_INSTALL_PREFIX=#{prefix}
        -DCMAKE_C_COMPILER=gcc-5
        -DCMAKE_CXX_COMPILER=g++-5
      ]
      system "cmake", *args, ".."
      system "make", "install"
    end
  end

  def post_install
    (var/"orthanc").mkpath
    unless File.exist? "#{var}/orthanc/config.json"
      system "cp", "Resources/Configuration.json", "#{var}/orthanc/config.json"
    end
  end

  def caveats; <<-EOS.undent
    For more information about configuring and running Orthanc refer to the Orthanc Book:
      https://orthanc.chu.ulg.ac.be/book/index.html

    You can configure Orthanc's config file at:
      #{var}/orthanc/config.json

    Orthanc saves its log to:
      #{var}/orthanc/orthanc.log
    EOS
  end

  def plist; <<-EOS.undent
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
