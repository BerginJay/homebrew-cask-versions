cask "microsoft-edge-dev" do
  version "94.0.992.1"

  if Hardware::CPU.intel?
    sha256 "ec2cf887992162a7a7a3546c29aba2e197da8df77b3f8b1c99c600718404a619"

    url "https://officecdn-microsoft-com.akamaized.net/pr/C1297A47-86C4-4C1F-97FA-950631F94777/MacAutoupdate/MicrosoftEdgeDev-#{version}.pkg",
        verified: "officecdn-microsoft-com.akamaized.net/"
  else
    sha256 "93be93385165a5cdc978fdf11298fab9e84c83df77a6e54c555b544e0030296c"

    url "https://officecdn-microsoft-com.akamaized.net/pr/03adf619-38c6-4249-95ff-4a01c0ffc962/MacAutoupdate/MicrosoftEdgeDev-#{version}.pkg",
        verified: "officecdn-microsoft-com.akamaized.net/"
  end

  name "Microsoft Edge Dev"
  desc "Multi-platform web browser"
  homepage "https://www.microsoftedgeinsider.com/"

  livecheck do
    url "https://go.microsoft.com/fwlink/?linkid=2069340"
    strategy :header_match
  end

  auto_updates true
  depends_on cask: "microsoft-auto-update"

  pkg "MicrosoftEdgeDev-#{version}.pkg",
      choices: [
        {
          "choiceIdentifier" => "com.microsoft.package.Microsoft_AutoUpdate.app", # Office16_all_autoupdate.pkg
          "choiceAttribute"  => "selected",
          "attributeSetting" => 0,
        },
      ]

  uninstall pkgutil: "com.microsoft.edgemac.Dev"

  zap trash: [
    "~/Library/Application Support/Microsoft Edge Dev",
    "~/Library/Caches/Microsoft Edge Dev",
    "~/Library/Preferences/com.microsoft.edgemac.Dev.plist",
    "~/Library/Saved Application State/com.microsoft.edgemac.Dev.savedState",
  ],
      rmdir: "/Library/Application Support/Microsoft"
end
