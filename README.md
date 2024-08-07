# zsh-config
My preferred zsh config. Uses a local LLM.

Allows for command completion, if an LLM is turned on.

> [!WARNING]  
> This config naively looks for a llamafile server at http://127.0.0.1:8080. If nothing is running, the LLM features will be ignored. If something else is running at that port, the llm functions will be instantiated, but there will be no LLM results.

# Usage

1. Save your current config if needed.

2. Move `.zshrc`, `.functions`, and `.llm-functions` to the appropriate directory. Typically, this is the root directory.

3. Start a new terminal, or run `source <path>/.zshrc` (typically `source ~/.zshrc`) on a running terminal.

# Features

[![Video](https://raw.githubusercontent.com/noelfranthomas/zsh-config/main/assets/preview.jpg)](https://raw.githubusercontent.com/noelfranthomas/zsh-config/main/assets/features.mp4)