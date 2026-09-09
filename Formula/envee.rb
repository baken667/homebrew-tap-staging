# Homebrew formula for envee, rendered by .github/workflows/release.yml on
# every tag and pushed to baken667/homebrew-tap (or -staging for pre-releases).
# Prebuilt archives per platform; nothing is compiled on the user's machine.
class Envee < Formula
  desc "Per-directory environment variable manager"
  homepage "https://github.com/baken667/envee"
  version "0.4.0-rc.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/baken667/envee/releases/download/v0.4.0-rc.3/envee_0.4.0-rc.3_darwin_arm64.tar.gz"
      sha256 "41feced4425e8e5a400f2830d3ed785973b4067cae3113c4c4ec9c6ea195a569"
    end
    on_intel do
      url "https://github.com/baken667/envee/releases/download/v0.4.0-rc.3/envee_0.4.0-rc.3_darwin_amd64.tar.gz"
      sha256 "44f9783fed775a421477f7818f6ef5b43828025010722aad5c2863d08fe75b3e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/baken667/envee/releases/download/v0.4.0-rc.3/envee_0.4.0-rc.3_linux_arm64.tar.gz"
      sha256 "99ff4b616060eb6efbfaeb9b1cea528a81a4a6f920dca95efcb450deb5e91900"
    end
    on_intel do
      url "https://github.com/baken667/envee/releases/download/v0.4.0-rc.3/envee_0.4.0-rc.3_linux_amd64.tar.gz"
      sha256 "eabc482f977d24245b9045f9514f78e9613f7757cf9059bd4be5acc7198d0355"
    end
  end

  def install
    bin.install "envee"
    bin.install "envee-plugin-env"
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
  end
end
