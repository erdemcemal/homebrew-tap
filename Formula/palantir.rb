# Homebrew Formula for Palantir
# To use: Copy this to your homebrew-tap repository

class Palantir < Formula
  desc "Terminal UI for AWS CloudFormation & ECS exploration with port forwarding"
  homepage "https://github.com/erdemcemal/palantir"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/erdemcemal/palantir/releases/download/v#{version}/palantir_#{version}_darwin_arm64.tar.gz"
      sha256 "000e5d4a23b8f4e75940cf78d25d8e104f05588cafe5f0bd3edafe5e8af2e0cb"
    else
      url "https://github.com/erdemcemal/palantir/releases/download/v#{version}/palantir_#{version}_darwin_amd64.tar.gz"
      sha256 "1713168d67fa27c0dbd2491c5bf81480626e12bd23baf9cd44bbe309fc1047a9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/erdemcemal/palantir/releases/download/v#{version}/palantir_#{version}_linux_arm64.tar.gz"
      sha256 "d9df2caa44bd3a374c45bd5a25feb07fdb1dab3071b9445069eba9da9dd405f3"
    else
      url "https://github.com/erdemcemal/palantir/releases/download/v#{version}/palantir_#{version}_linux_amd64.tar.gz"
      sha256 "c36e0cabb8dca94151d291050e2749e5f6683b92c5afcb9c4ce3e44d9faacd7d"
    end
  end

  depends_on "awscli" => :optional

  def install
    bin.install "palantir"
  end

  def caveats
    <<~EOS
      Palantir requires AWS CLI to be configured and the Session Manager Plugin
      for port forwarding features.

      Install Session Manager Plugin:
        brew install --cask session-manager-plugin

      Configure AWS CLI:
        aws configure
        # or for SSO
        aws configure sso
        aws sso login --profile <profile-name>

      Theme options:
        palantir --theme auto   # Auto-detect (default)
        palantir --theme dark   # Force dark theme
        palantir --theme light  # Force light theme
    EOS
  end

  test do
    assert_match "palantir", shell_output("#{bin}/palantir --version")
  end
end
