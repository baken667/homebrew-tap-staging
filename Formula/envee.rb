# Homebrew formula for envee, rendered by .github/workflows/release.yml on
# every tag and pushed to baken667/homebrew-tap (or -staging for pre-releases).
# Prebuilt archives per platform; nothing is compiled on the user's machine.
class Envee < Formula
  desc "Per-directory environment variable manager"
  homepage "https://github.com/baken667/envee"
  version "0.4.3-rc.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/baken667/envee/releases/download/v0.4.3-rc.1/envee_0.4.3-rc.1_darwin_arm64.tar.gz"
      sha256 "c3cf4db1bd73bc6aa7e2afffcdabc4e64bb26070c90b7d990cc1fd084f824705"
    end
    on_intel do
      url "https://github.com/baken667/envee/releases/download/v0.4.3-rc.1/envee_0.4.3-rc.1_darwin_amd64.tar.gz"
      sha256 "38862f7715ef079511af2b313188594e938eabeabdec3e5e8f9705875a261323"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/baken667/envee/releases/download/v0.4.3-rc.1/envee_0.4.3-rc.1_linux_arm64.tar.gz"
      sha256 "69aceeecc6b51b7aaa892a79a0fd165393e7a0182e5bfeb7dd63e13741733f19"
    end
    on_intel do
      url "https://github.com/baken667/envee/releases/download/v0.4.3-rc.1/envee_0.4.3-rc.1_linux_amd64.tar.gz"
      sha256 "ff429ef0283514054a19234e1a4cef78b116440906f238ff6fe98dd0278631ad"
    end
  end

  def install
    bin.install "envee"
    bin.install "envee-plugin-env"
    bin.install "envee-plugin-infisical"
    generate_completions_from_executable(bin/"envee", "completion")
  end

  def caveats
    <<~EOS
      To enable envee in your shell, add one of these to your config:
        bash:  eval "$(envee init bash)"
        zsh:   eval "$(envee init zsh)"
        fish:  envee init fish | source
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/envee --version")
    assert_match "_envee_hook", shell_output("#{bin}/envee init bash")
    assert_match "add-zsh-hook", shell_output("#{bin}/envee init zsh")
    assert_match "_envee_hook", shell_output("#{bin}/envee init fish")
    assert_match "\"name\":\"env\"", shell_output("#{bin}/envee-plugin-env metadata")
    assert_match "\"name\":\"infisical\"", shell_output("#{bin}/envee-plugin-infisical metadata")
  end
end
