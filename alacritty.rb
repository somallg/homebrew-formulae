class Alacritty < Formula
  desc "A cross-platform, OpenGL terminal emulator"
  homepage "https://github.com/alacritty/alacritty"
  head "https://github.com/alacritty/alacritty.git"

  depends_on "cmake" => :build
  depends_on "fontconfig" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "check", "--target=aarch64-apple-darwin"

    system "make", "app"

    (prefix / "Applications").install "target/release/osx/Alacritty.app"
    bin.install "target/release/alacritty"
  end

  def caveats
    msg = <<~EOS
      To make sure Alacritty works correctly, either the alacritty or alacritty-direct terminfo must be used.
      The alacritty terminfo will be picked up automatically if it is installed.

      If the following command returns without any errors, the alacritty terminfo is already installed:

        infocmp alacritty

      If it is not present already, you can install it globally with the following command:

        sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

      WARNING: This formula can't install into /Applications, the application
      has been installed to:

        #{prefix / "Applications/Alacritty.app"}

      This path is stable across upgrades, you can create your own symlink in
      the global /Applications folder as follows:

        cp -r #{prefix / "Applications/Alacritty.app"} /Applications/
    EOS

    msg
  end

  test do
    assert_match "alacritty 0.10.0-dev (#{revision})", shell_output("#{bin}/alacritty --version")
  end
end
