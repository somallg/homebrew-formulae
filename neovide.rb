# frozen_string_literal: true

# Alacritty
class Neovide < Formula
  desc 'No Nonsense Neovim Client in Rust'
  homepage 'https://github.com/neovide/neovide'
  head 'https://github.com/neovide/neovide.git', branch: 'main'

  depends_on 'cmake'
  depends_on 'rust'

  def install
    system 'cargo', 'check', '--target=aarch64-apple-darwin'

    system 'cargo', 'build', '--release'

    bin.install 'target/release/neovide'
  end

  def caveats
    <<~DOC
      To make sure neovide works correctly, you have to do codesign:
        1. Create new Certificate:
          Name: neovide-cert,
          Identity Type: Self-Signed Root
          Certificate Type: Code Signing
        2. Run the command below:
        codesign -fs 'neovide-cert' $(which neovide)
    DOC
  end

  test do
    assert_match(/^neovide 0.8.0/, shell_output("#{bin}/neovide --version"))
  end
end
