# VH2C Homebrew Tap

Official Homebrew tap for open-source macOS tools by **[VH2C](https://vh2c.com.br)**.

## Install AI Gauge

```bash
brew install --cask vh2c/tap/ai-gauge
```

Or tap first and install:

```bash
brew tap vh2c/tap
brew install --cask ai-gauge
```

## Upgrade & Uninstall

```bash
# Upgrade to the latest version
brew upgrade --cask ai-gauge

# Uninstall the app
brew uninstall --cask ai-gauge

# Uninstall and remove local config/preferences
brew uninstall --cask --zap ai-gauge
```

## Updating the Cask (Maintainers)

Whenever a new release of [`vh2c/ai-gauge`](https://github.com/vh2c/ai-gauge/releases) is published:

```bash
./scripts/update-cask.sh        # fetches latest release tag & SHA256SUMS.txt
# or pass a specific tag:
./scripts/update-cask.sh v1.2.1
```

## Links

- **Official Website:** [https://ai-gauge.vh2c.com.br](https://ai-gauge.vh2c.com.br)
- **Source Repository:** [https://github.com/vh2c/ai-gauge](https://github.com/vh2c/ai-gauge)
- **License:** MIT
