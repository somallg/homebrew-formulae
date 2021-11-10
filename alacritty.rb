class Alacritty < Formula
  desc "A cross-platform, OpenGL terminal emulator"
  homepage "https://github.com/alacritty/alacritty"
  head "https://github.com/alacritty/alacritty.git"

  depends_on "cmake" => :build
  depends_on "fontconfig"
  depends_on "rustup-init"

  def install
    system "rustup", "update"
    system "rustup", "target add aarch64-apple-darwin"
    system "cargo", "check --target=aarch64-apple-darwin"

    system "make", "dmg-universal"

    (prefix / "Applications").install "target/release/osx/Alacritty.app"
    bin.install "target/release/alacritty"
  end

  def caveats
    msg = <<~EOS
      Although it is possible that the default configuration will work on your
      system, you will probably end up wanting to customize it anyhow. You can
      find a copy of the default configuration at:

        /usr/local/share/alacritty/alacritty_macos.yml

      You can copy this file to ~/.alacritty.yml and edit as you please.

      For the best experience, you should install/update alacritty's terminfo
      file after each update. You can do so by running the following command:

        sudo tic -e alacritty,alacritty-direct /usr/local/share/alacritty/alacritty.info

      WARNING: This formula can't install into /Applications, the application
      has been installed to:

        #{prefix / "Applications/Alacritty.app"}

      This path is stable across upgrades, you can create your own symlink in
      the global /Applications folder as follows:

        ln -s #{prefix / "Applications/Alacritty.app"} /Applications/
    EOS

    msg
  end

  test do
    system "false"
  end
end
