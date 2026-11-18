cask "runnerwatch" do
  arch arm: "arm64", intel: "x64"

  version "0.4.0"
  sha256 arm:   "39af3ac60a7ddfeda48467d7ba62199024ee3cc48a46467b7373e5fb1a2dfc8c",
         intel: "9855263397a560e50994700ca3762fb1a9ce0ecd65196247e0a26bdc2e4c5f70"

  url "https://github.com/GustavoDanielL/runnerwatch/releases/download/v#{version}/RunnerWatch-osx-#{arch}.zip"
  name "RunnerWatch"
  desc "Menu-bar widget for GitHub Actions runs and self-hosted runners"
  homepage "https://github.com/GustavoDanielL/runnerwatch"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :monterey"

  app "RunnerWatch.app"

  # RunnerWatch is open source but not notarized (no paid Apple developer account), so Gatekeeper would refuse
  # to open the downloaded app. Clear the quarantine flag on this app only.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/RunnerWatch.app"]
  end

  uninstall quit: "io.github.gustavodaniell.runnerwatch"

  zap trash: "~/Library/Application Support/RunnerWatch"

  caveats <<~EOS
    RunnerWatch is not notarized by Apple. This cask removes the quarantine flag from
    RunnerWatch.app so it can open. Source and builds: https://github.com/GustavoDanielL/runnerwatch
  EOS
end
