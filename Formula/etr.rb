class Etr < Formula
  desc "ECMP traceroute tool with path detection and visualization support"
  homepage "https://github.com/tkjaer/etr"
  url "https://github.com/tkjaer/etr/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "6af2c5e26eb6cd51acad183ce9a5d40cf43372d53adabaf18f819935e955b6e1"
  license "MIT"

  depends_on "go" => :build
  depends_on "libpcap"

  def install
    # Ensure module mode and a predictable build.
    ENV["GO111MODULE"] = "on"

    # If you embed version info via -ldflags in your release workflow,
    # you can optionally wire it in here later.
    system "go", "build", *std_go_args(output: bin/"etr"), "./cmd/etr"
  end

  test do
    system "#{bin}/etr", "--version"
  end
end
