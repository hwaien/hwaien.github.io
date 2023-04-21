# Personal Blog

## First Time Setup

1. Clone the repo [with SSH](https://docs.github.com/en/get-started/getting-started-with-git/about-remote-repositories#cloning-with-ssh-urls).
1. Open the repo in [VS Code](https://en.wikipedia.org/wiki/Visual_Studio_Code).
1. Click "Reopen in Container" when prompted.
1. Configure Git to always sign commits using your signing key.
   - One way to automate this is through a personal [dotfile repository](https://code.visualstudio.com/docs/devcontainers/containers#_personalizing-with-dotfile-repositories). See [example here](https://github.com/hwaien/dotfiles/blob/main/install.sh).
1. If you want to connect and authenticate to GitHub by SSH, add the dev container's [SSH key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).
   - To find the dev container's SSH key, run the following:
     - `cat $HOME/.ssh/id_rsa.pub`
   - If your container does not have an SSH key, consider adding [this feature](https://github.com/hwaien/devcontainer-features/pkgs/container/devcontainer-features%2Fssh-keygen) to the `dev.containers.defaultFeatures` setting in your VS Code `settings.json` file. This way, all your dev containers automatically gets a key.

## Local Preview

To preview the site locally,

1. Open the VS Code **Terminal** menu and
1. Go to **Run Task...** then
1. **Serve**.

Or, run the following at the terminal:

`make serve`
