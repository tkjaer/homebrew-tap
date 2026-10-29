class Etr < Formula
  desc "ECMP traceroute tool with path detection and visualization support"
  homepage "https://github.com/tkjaer/etr"
  url "https://github.com/tkjaer/etr/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "ffeb6283c99654abae41cdcd4135475179cc0feea03a7063673371788bd5a705"
  license "MIT"

  bottle do
    root_url "https://github.com/tkjaer/homebrew-tap/releases/download/v1.3.0"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "9185cc07f8695375b08b85f4d08f9fcf42dc728b234df93e14dfb7e9ba1c2471"
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
