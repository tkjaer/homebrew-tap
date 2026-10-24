class Etr < Formula
  desc "ECMP traceroute tool with path detection and visualization support"
  homepage "https://github.com/tkjaer/etr"
  url "https://github.com/tkjaer/etr/archive/refs/tags/v1.2.7.tar.gz"
  sha256 "92ef35d8e8dc18cc32aa0eb7334f2bda2dbb10c53a9d773e48b075d839ef05b1"
  license "MIT"

  bottle do
    root_url "https://github.com/tkjaer/homebrew-tap/releases/download/v1.2.6"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "701e921cbcd689b3856813f424cf6978f3b3f7087d6b1140a4cd28eeb633df11"
    sha256 cellar: :any_skip_relocation, sequoia:      "9b9c25537c2579b869610646a96e7094f24f13518c7fed79ddc984fbba89d76c"
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
