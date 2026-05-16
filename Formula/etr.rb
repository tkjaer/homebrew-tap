class Etr < Formula
  desc "ECMP traceroute tool with path detection and visualization support"
  homepage "https://github.com/tkjaer/etr"
  url "https://github.com/tkjaer/etr/archive/refs/tags/v1.2.6.tar.gz"
  sha256 "3c622c09b85015a201381daaf82c72b82be891be0e95587adf6b922b78f61a7d"
  license "MIT"

  bottle do
    root_url "https://github.com/tkjaer/homebrew-tap/releases/download/v1.2.6"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "e4273d927789369bf2ecdad0fd83b7a539979922c9fa1ef570027f8c4fffdbe6"
    sha256 cellar: :any_skip_relocation, sequoia:      "7828320f00a5ff8822a68c9fded87743ffbd089b709a9b3b494c21a30c89ccf8"
  end

  depends_on "go" => :build
  uses_from_macos "libpcap"

  def install
    # Ensure module mode and a predictable build.
    ENV["GO111MODULE"] = "on"

    ldflags = [
      "-s", "-w",
      "-X", "github.com/tkjaer/etr/internal/version.Version=#{version}"
    ]

    system "go", "build", *std_go_args(output: bin/"etr", ldflags: ldflags.join(" ")), "./cmd/etr"
  end

  test do
    system "#{bin}/etr", "--version"
  end
end
