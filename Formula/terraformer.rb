class Terraformer < Formula
  desc "CLI tool to generate terraform files from existing infrastructure"
  homepage "https://github.com/GoogleCloudPlatform/terraformer"
  url "https://github.com/GoogleCloudPlatform/terraformer/archive/0.8.24.tar.gz"
  sha256 "d366476777b31149738b8e5f916e080d54403fb4ca7a6e97edc885d3623a5f19"
  license "Apache-2.0"
  head "https://github.com/GoogleCloudPlatform/terraformer.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "df018b019428be95a8d6c65a919c9c55d886e7f4824cda47ab436431ae97acce"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5fa2ea9f7724c5049821dc933c4f3ea7294a284bcdeb48d557dcdc87174b1b1c"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "94d5886c4a51100252320605c5c325d1887d567ce544f4561f3b66c98c812c61"
    sha256 cellar: :any_skip_relocation, ventura:        "e37409d64ec97c2d9fb4875e4dc972bd5a721f31519a4d801f7c10df6e0769f7"
    sha256 cellar: :any_skip_relocation, monterey:       "1134403c3c57f14169abc8e4ce5623141bf156740af30aa27230df8b0ee99781"
    sha256 cellar: :any_skip_relocation, big_sur:        "d2add2d2853942105421257b897d2ac86445edd26b521da08ea8a2470ffa48e7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6b1e541f2a8f8b3cd4c811a531d879e2ce60d99672cc49e1e8c1e83c7e669076"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    assert_match version.to_s,
      shell_output("#{bin}/terraformer version")

    assert_match "Available Commands",
      shell_output("#{bin}/terraformer -h")

    assert_match "aaa",
      shell_output("#{bin}/terraformer import google --resources=gcs --projects=aaa 2>&1", 1)
  end
end
