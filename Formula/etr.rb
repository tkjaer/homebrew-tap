class Etr < Formula
  desc "ECMP traceroute tool with path detection and visualization support"
  homepage "https://github.com/tkjaer/etr"
  url "https://github.com/tkjaer/etr/archive/refs/tags/v1.2.8.tar.gz"
  sha256 "963c92fa36bd20080fe193e41f655342137f9ef0469636ed14999e29ba299fcb"
  license "MIT"

  bottle do
    root_url "https://github.com/tkjaer/homebrew-tap/releases/download/v1.2.8"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "7583c53742cdd85a1d1054ece2aef54533f6c86cf25ee94021662145402750b5"
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
