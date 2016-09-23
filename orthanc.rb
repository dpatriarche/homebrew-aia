class Orthanc < Formula
  desc "Open-source, lightweight DICOM server"
  homepage "http://orthanc-server.com"
  version "1.1.0-1-f2ecea5"
  url "https://bitbucket.org/sjodogne/orthanc/get/f2ecea5362fa.zip"
  sha256 "a80b487f10986da7583693cc2bce651b727d1e418048bc508513e7d12ed64b0c"
  head "https://github.com/some/package.git", :branch => "Orthanc-1.1.0"

  depends_on "cmake" => :build

  def install
    args = %W[
      -GXcode
      -DCMAKE_OSX_DEPLOYMENT_TARGET=#{MacOS.version}
      -DSTATIC_BUILD=ON
      -DSTANDALONE_BUILD=ON
      -DALLOW_DOWNLOADS=ON
    ]
    system "cmake", *args, "."
    system "xcodebuild", "-configuration", "Release"
    system "Release/Orthanc", "--config=Release/sample-config.json"
    prefix.install Dir["Release/*"]
  end

  def post_install
    (var/"orthanc").mkpath
    unless File.exist? "#{var}/orthanc/config.json"
      system "cp", "#{prefix}/sample-config.json", "#{var}/orthanc/config.json"
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
        <string>#{prefix}/Orthanc</string>
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
