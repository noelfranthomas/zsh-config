# zsh-config
My preferred zsh config. Uses a local LLM.

Allows for command completion, if an LLM is turned on.

> [!WARNING]  
> This config naively looks for a llamafile server at http://127.0.0.1:8080. If nothing is running, the LLM features will be ignored. If something else is running at that port, the llm functions will be instantiated, but there will be no LLM results.

# Usage

1. Save your current config if needed.

2. Move `.zshrc`, `.functions`, and `.llm-functions` to the appropriate directory. Typically, this is the root directory.

3. Start a new terminal, or run `source <path>/.zshrc` (typically `source ~/.zshrc`) on a running terminal.

4. To enable LLM features, run a llamafile server. See [llamafile](https://github.com/Mozilla-Ocho/llamafile) for more information.

# Features

Click below to see the features video.

> [!CAUTION]
> Clicking the thumbnail will download the video.

[![Features Video](https://raw.githubusercontent.com/noelfranthomas/zsh-config/main/assets/features-preview.jpg)](https://raw.githubusercontent.com/noelfranthomas/zsh-config/main/assets/features-video.mp4)

Here's a list of some other functions included in `.function`.

Function Name | Description
--- | --- 
checksite | check if a website is up 
portpid | find process name and PID by port 
genpass | generate a random password 
dockerclean | remove all stopped containers 
dockerimageclean | remove all dangling images 
dockerkillall | stop and remove all containers 
lsf | list all functions and descriptions defined in ~/.functions 
up | go up multiple directories 
gogit | go to the GitHub dir 
gs | git status shortcut 
gp | git pull shortcut 
gacp | git add, commit, and push 
mkvenv | create venv with python 3.11 
mkcd | make directory and switch in 
alpined | start fsh in an alpine container 