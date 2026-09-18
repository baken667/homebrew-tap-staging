# Homebrew formula for envee, rendered by .github/workflows/release.yml on
# every tag and pushed to baken667/homebrew-tap (or -staging for pre-releases).
# Prebuilt archives per platform; nothing is compiled on the user's machine.
class Envee < Formula
  desc "Per-directory environment variable manager"
  homepage "https://github.com/baken667/envee"
  version "0.5.0-rc.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/baken667/envee/releases/download/v0.5.0-rc.1/envee_0.5.0-rc.1_darwin_arm64.tar.gz"
      sha256 "0d9ff5445538e2e3d63d51e7af99580ca70d54d17c9adaeb2cf1af4ebf996ae7"
    end
    on_intel do
      url "https://github.com/baken667/envee/releases/download/v0.5.0-rc.1/envee_0.5.0-rc.1_darwin_amd64.tar.gz"
      sha256 "697d791d8fddcfb3e5f0de8ca4cbe2208d2f52229aedad0a0e29567820bedbbe"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/baken667/envee/releases/download/v0.5.0-rc.1/envee_0.5.0-rc.1_linux_arm64.tar.gz"
      sha256 "8fe66f0830039d566e36362c86c3eb16b197e28726c2d5ed8ef98997ff9d320c"
    end
    on_intel do
      url "https://github.com/baken667/envee/releases/download/v0.5.0-rc.1/envee_0.5.0-rc.1_linux_amd64.tar.gz"
      sha256 "ddb2075c20eec0c2e1d833804e7bd452a3a9db5281fcd9580e609cb672a5fa42"
    end
  end

  def install
    bin.install "envee"
    bin.install "envee-plugin-env"
    bin.install "envee-plugin-infisical"
    bin.install "envee-plugin-op"
    bin.install "envee-plugin-sops"
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
    %w[infisical op sops].each do |p|
      assert_match "\"name\":\"#{p}\"", shell_output("#{bin}/envee-plugin-#{p} metadata")
    end
  end
end
