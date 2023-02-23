# Personal Blog

## First Time Setup

1. Clone the repo [with SSH](https://docs.github.com/en/get-started/getting-started-with-git/about-remote-repositories#cloning-with-ssh-urls).
1. Open the repo in [VS Code](https://en.wikipedia.org/wiki/Visual_Studio_Code).
1. Click "Reopen in Container" when prompted.
1. Press Enter several times through the RSA key pair generation steps in the terminal.
1. Run `cat /home/vscode/.ssh/id_rsa.pub` in the terminal, to see the generated public key.
1. Add the public key [to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).
1. Run `git config --global user.signingkey <GPG key ID>` in the terminal, to make Git sign commits using your GPG key.
1. Run `git config --global commit.gpgsign true` in the terminal, to make Git sign all commits by default.

## Local Preview

To preview the site locally, run the following at the terminal:

```
bundle exec jekyll serve
```
