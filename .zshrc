# ~/.zshrc

export CLICOLOR=1
if command -v zed &> /dev/null; then
    export EDITOR='zed'
else
    export EDITOR='vim'
fi
export LLM_AVAILABLE="undefined"

# change to a directory just by typing its name
setopt autocd
# spellcheck
setopt correct

# describe the commit for the zsh config
if [ -d ~/Documents/GitHub/zsh-config ]; then
  config_branch=$(git -C ~/Documents/GitHub/zsh-config rev-parse --abbrev-ref HEAD 2>/dev/null)
  config_commit=$(git -C ~/Documents/GitHub/zsh-config rev-parse --short HEAD 2>/dev/null)
  echo "\e[32mzsh config ($config_branch@$config_commit)\e[0m"
else
  echo "\e[32mzsh config (branch and commit unknown)\e[0m"
fi

echo "- use 'help' for information"

alias ls="ls -l"
alias copy="pbcopy"
alias paste="pbpaste"

# get the last two directories of the current working directory
get_last_two_dirs() {
  pwd | awk -F/ '{print $(NF-1) "/" $NF}'
}

parse_git_branch() {
  git_branch=$(git symbolic-ref --short -q HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null)
  if [ -n "$git_branch" ]; then
    git_commit=$(git rev-parse --short HEAD 2>/dev/null)
    echo "[$git_branch@$git_commit]"
  fi
}

get_venv_name() {
  if [ -n "$VIRTUAL_ENV" ]; then
    basename "$VIRTUAL_ENV"
  fi
}

# source the ~/.functions file if it exists
if [ -f ~/.functions ]; then
  . ~/.functions
fi

# Check if a process is running on port 8080 and source LLM functions if true
# Does not check if the server is healthy
# NOTE: precmd needs to be set in every case! ***** (Should be fixed)
if lsof -i :8080 > /dev/null 2>&1; then
  if [ -f ~/.llm-functions ]; then
    export LLM_AVAILABLE=1
    . ~/.llm-functions
  else
    export LLM_AVAILABLE="\e[31mERROR:\e[0m ~/.llm-functions not found"
    # Update PS1 dynamically before each prompt
    precmd() {
      PS1="../$(get_last_two_dirs) %F{green}$(parse_git_branch)>%f "
    }
  fi
else
  export LLM_AVAILABLE="\e[33mWARN:\e[0m LLM server not found at port 8080."
  # Update PS1 dynamically before each prompt
  precmd() {
      venv_name=$(get_venv_name)
      if [ -n "$venv_name" ]; then
        venv_prompt="($venv_name) "
      else
        venv_prompt=""
      fi
      PS1="${venv_prompt}../$(get_last_two_dirs) %F{green}$(parse_git_branch)>%f "
  }
fi

source <(pkgx --shellcode)  #docs.pkgx.sh/shellcode
