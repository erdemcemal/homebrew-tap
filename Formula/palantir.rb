# Homebrew Formula for Palantir
# To use: Copy this to your homebrew-tap repository

class Palantir < Formula
  desc "Terminal UI for AWS CloudFormation & ECS exploration with port forwarding"
  homepage "https://github.com/erdemcemal/palantir"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/erdemcemal/palantir/releases/download/v#{version}/palantir_#{version}_darwin_arm64.tar.gz"
      sha256 "70cffb0cdf8c943dea1adb655b029c4b850e519175fa51749de33da14ede2333"
    else
      url "https://github.com/erdemcemal/palantir/releases/download/v#{version}/palantir_#{version}_darwin_amd64.tar.gz"
      sha256 "a32d994bcf6d083f7ff3d9e87d6148a024638f0960bba1dd40410a5ac9743ae6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/erdemcemal/palantir/releases/download/v#{version}/palantir_#{version}_linux_arm64.tar.gz"
      sha256 "967e20ed1f92a759b6e61b8505785ccfa705b8f202f08a5e25d26e260d639dd6"
    else
      url "https://github.com/erdemcemal/palantir/releases/download/v#{version}/palantir_#{version}_linux_amd64.tar.gz"
      sha256 "77904326a4bb4cd341c57a0b138121a817ec18c9dffe9a9b224bd378d25212d2"
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
    EOS
  end

  test do
    assert_match "palantir", shell_output("#{bin}/palantir --version")
  end
end
