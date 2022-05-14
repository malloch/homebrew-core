class Tmpreaper < Formula
  desc "Clean up files in directories based on their age"
  homepage "https://packages.debian.org/sid/tmpreaper"
  url "https://deb.debian.org/debian/pool/main/t/tmpreaper/tmpreaper_1.6.16.tar.gz"
  mirror "https://fossies.org/linux/misc/tmpreaper_1.6.16.tar.gz"
  sha256 "e543acdd55bb50102c42015e6d399e8abb36ad818cbd3ca6cb1c905b5781e202"
  license "GPL-2.0-only"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a525dbdab528dbe840e9961e8cfeb888b43d4d3cf0075fc5dda698023d2b6d72"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c05f46196469020a65a07a6a8baeb270268ce8c8b917ee304a7c791a70ead0de"
    sha256 cellar: :any_skip_relocation, monterey:       "cb95aa07c368174b5f2027b567dbe5e0f431325c51f69fea8c3a799e1ab31380"
    sha256 cellar: :any_skip_relocation, big_sur:        "3cc58bad3b6929386bb6e21e7d68156fc99fed84a80d56b4de22a92759b81179"
    sha256 cellar: :any_skip_relocation, catalina:       "29ebae2263adcd7765e873802308c380b1419fef6fb1f78064c3245c5b7d5f04"
    sha256 cellar: :any_skip_relocation, mojave:         "2e526cb2d2a7e7e2fa82becbee314478158aec96a6c5a2963072cc8e1092f42c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dbb3e26d1d6ef72c484371f2e9e2614e8118d18eccbceba255f10a198a7a0663"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  on_linux do
    depends_on "e2fsprogs"
  end

  def install
    system "./configure", "--prefix=#{prefix}", "--sysconfdir=#{etc}"
    system "make", "install"
  end

  test do
    touch "removed"
    sleep 3
    touch "not-removed"
    system "#{sbin}/tmpreaper", "2s", "."
    refute_predicate testpath/"removed", :exist?
    assert_predicate testpath/"not-removed", :exist?
  end
end
