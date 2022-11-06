cask "synology-drive-latest" do
    version "3.2.0,13238"
    sha256 "d78ef3cbf6952b551229cca8161e97dae881278fdc3c9f51949f8ea463a81ae7"
  
    url "https://global.download.synology.com/download/Utility/SynologyDriveClient/#{version.csv.first}-#{version.csv.second}/Mac/Installer/synology-drive-client-#{version.csv.second}.dmg"
    name "Synology Drive"
    desc "Sync and backup service to Synology NAS drives"
    homepage "https://www.synology.com/"
  
    livecheck do
      url "https://www.synology.com/en-us/releaseNote/SynologyDriveClient"
      regex(/>\s*Version:\s*(\d+(?:\.\d+)+)-(\d+)\s*</i)
      strategy :page_match do |page, regex|
        page.scan(regex).map { |match| "#{match[0]},#{match[1]}" }
      end
    end
  
    auto_updates true
  
    pkg "Install Synology Drive Client.pkg"
  
    uninstall quit:      [
                "io.com.synology.CloudStationUI",
                "com.synology.CloudStation",
                "com.synology.CloudStationUI",
              ],
              pkgutil:   "com.synology.CloudStation",
              launchctl: "com.synology.Synology Cloud Station",
              delete:    "/Applications/Synology Drive Client.app"
  end