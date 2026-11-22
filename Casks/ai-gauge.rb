cask "ai-gauge" do
  version "1.2.1"
  sha256 "aa9353df26e461c4487d61ffecd6bcf1f5d5cba76cf749ec63b29f7a2202f594"

  on_arm do
    depends_on :macos
  end
  on_intel do
    depends_on macos: :ventura
  end

  url "https://github.com/vh2c/ai-gauge/releases/download/v#{version}/AI-Gauge-macOS-vh2c.zip"
  name "AI Gauge"
  desc "Desktop HUD & menu bar tracker for Claude, Antigravity, Codex & Cursor"
  homepage "https://ai-gauge.vh2c.com.br/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on formula: "node"

  app "AI Gauge.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/AI Gauge.app"],
        must_succeed: false
  end

  uninstall quit: "br.com.vh2c.ai-gauge"

  zap trash: [
    "~/.config/UniversalAIQuota",
    "~/Library/Preferences/br.com.vh2c.ai-gauge.plist",
  ]

  caveats <<~EOS
    AI Gauge is open-source (MIT) and not notarized with Apple yet.
    The Cask automatically clears the quarantine attribute after installation.
    Node.js 18+ is required (installed automatically via Homebrew).
  EOS
end
