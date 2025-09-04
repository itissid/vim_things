vim_things
==========

My vim things


Wish list 
==========
## Base Docker container image 
Purpose: This will help me avoid a lot of duplication of environment
- Ubuntu
- Debian package installation list see ~/.scripts/process-aptlog.sh
- Conda installation 
- Vim, Tmux(with config)
  - Github repos for vim, tmux, bash config
  - Creation scripts for environment.

- Scripts
  - Bash scripts for shelling into a container, portforwarding to a k8s machine. This will be for my projects.
- Certificates and keys
- Consider installing https://github.com/skaji/remote-pbcopy-iterm2/ for ease of accessing the remote paste buffer to send copied thing as 
an escape sequence to my mac clipboard.

- Bash profile customizations I want:
  - History log parsing for reverse-command search FTW.
  - Tmux customizations will be separate.

- Storage for user data(location and method)
    - Certificates and SSH keys
      - SSH keys to get into NAS
      - SSH keys to get into Ubuntu VM which has Dropbox backup on NAS.
      - Github SSH keys for committing things
        - I still need to figure out how to automate the key with the ssh-agent. Its very annoying I have to do this everytime.
      - Self signed Certs for itissid.me domain: 
        - Used in my IDE to sign requests from Cursor to my NAS's GPU).
        - Cursor set up:
            - How do I add API keys to ~/.continue.json so that they don't get leaked.
    - Bash history log data itself for a docker machine. 
    - Make sure I save the vscode remote ssh's config as well as any extensions so that they can be used again when the container is mounted.
      - Better yet maybe i can save this in some PV somewhere(dropbox/docker) remote which I download and set up for this pod.
    
## Docker containers off base version
  - GPU development supporting python, transformers, torch. NOTE: Right now I
    am limited by a silly GPU passsthough issue which allows me only one
    container for everything. So I need to host all my dev on the ollama
    container+the base above.
  - Remote GPU containers: I want some kind of lamda function so I can execute heavier LLMs to do the job.
  - Remote VSCode: Apparently the SSH extension works, I just need to enable a bunch of extensions on the remote host pod(see Storage for user data list above for this)
  
  
