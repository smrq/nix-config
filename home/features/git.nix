{
  programs.git = {
    enable = true;

    settings.user.email = "smrq@smrq.net";
    settings.user.name = "Greg Smith";
    settings.commit.gpgsign = true;
    settings.gpg.format = "ssh";
    settings.user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN3ORdArlT3Dya0q/lgJ4pnrN84oeglS9D7omApOGtMX";

    settings.init.defaultBranch = "main";
    settings.push.autoSetupRemote = true;
    settings.alias = {
      amend = "commit --amend --no-edit";
      l = "log --oneline --graph --decorate --all";
    };
  };
}
