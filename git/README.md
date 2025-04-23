# Engineering-Home: Git Config

Ever get annoyed at having to configure some default Git settings on a new dev machine?

Have a *slightly* more complicated setup than most, including SSH signing keys for example?

Just run the included script locally on the machine you are configuring and you have the Git Config setup as you want it. Pass along the right scope, system, global, local, depending on where you want to persist these settings.

## Instructions

> Since this is a public repo, you won't need any pre-existing Git configuration, for instance like SSH Authentication keys!

> Remember, Windows Git includes Git Bash, which runs this script just fine. This also works on any Linux terminal, to keep it consistent accross platforms.

> Please note! When you take the .pub contents and paste them into your forge settings. Take heed when storing the public key as *authentication* or *signing* key. For GitHub it matters how you set this. The same goes for whatever forge you use, Gitea, Forgejo, GitLab, Azure DevOps, etc. Also take note of the distinction between GPG and SSH keys. I personally prefer to use the SSH format instead of GPG, but use whichever your prefer (this script does not support GPG yet).

1. Clone this repo to your local environment: `git clone https://github.com/thecloudexplorers/eng-home.git`
2. Edit lines 34-62 of the `git-config.sh` script with your matching configuration for the 'forge' of your choice.
3. Open a terminal capable of running bash scripts.
4. Run the script: `./git-config.sh -o <your configured organization here>`
5. Input a password for the authentication and signing keys respectively. (Or leave it blank for no password, not recommended.)
6. Input the *public key* of your authentication and signing keys as relevant to your forge. For GitHub navigate here:  [https://github.com/settings/keys]( https://github.com/settings/keys)

## More reading

Just an index with instructions on how to do the above manually.

> Code signing is well established in the *forge* ecosystem. Notably, Azure DevOps is the only product that does not support it. To be clear, it is still best practice to enable code signing locally, as Git handles the linking of signatures to commits. However, Azure DevOps does nothing (at this time) to reflect the validation of said signatures. If at any point in the future Microsoft does add this functionality, your entire Git repo commit history will at least already have the signed commits! :-)

SSH authentication:
- [Git: SSH authentication](https://git-scm.com/book/en/v2/Git-on-the-Server-The-Protocols.html#_the_ssh_protocol)
- [Azure DevOps: Authentication - SSH](https://learn.microsoft.com/en-us/azure/devops/repos/git/use-ssh-keys-to-authenticate?view=azure-devops)  
- [GitHub: Authentication - SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account#adding-a-new-ssh-key-to-your-account)
- [GitLab: Authentication and signing](https://docs.gitlab.com/user/ssh/#add-an-ssh-key-to-your-gitlab-account)
- [Codeberg (Forgejo): Adding SSH keys](https://docs.codeberg.org/security/ssh-key/)

Git commit signing:
- [Git: Signing your work](https://git-scm.com/book/en/v2/Git-Tools-Signing-Your-Work)
- [GitHub: Commit signing - GPG](https://docs.github.com/en/authentication/managing-commit-signature-verification/adding-a-gpg-key-to-your-github-account#adding-a-gpg-key)
- [GitLab: Commit signing - SSH](https://docs.gitlab.com/user/project/repository/signed_commits/ssh/)
- [Codeberg (Forgejo): Commit signing - SSH](https://docs.codeberg.org/security/ssh-key/#telling-git-about-your-ssh-key)
- [Azure DevOps: Commit signing (Uservoice)](https://developercommunity.visualstudio.com/t/show-whether-commits-are-verified-with-gpg-key-on/383281)

Default `.gitconfig` reference materials:
- [Git Configuration Reference](https://git-scm.com/docs/git-config)
