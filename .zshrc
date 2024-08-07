# ~/.zshrc

export CLICOLOR=1
export EDITOR='nvim'

# change to a directory just by typing its name
setopt autocd
# spellcheck
setopt correct

echo "nft config"
echo "- use lsf to see available functions"
echo "- autocd enabled"
echo "- spellcheck enabled"

alias ls="ls -l"

# Function to get the last two directories of the current working directory
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
    echo "- llm ready"
    . ~/.llm-functions
  else
    echo "- ~/.llm-functions not found"
    # Update PS1 dynamically before each prompt
    precmd() {
      PS1="../$(get_last_two_dirs) %F{green}$(parse_git_branch)>%f "
    }
  fi
else
  echo "- llm not available"
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
export PATH="/opt/homebrew/opt/protobuf@3/bin:$PATH"
export PATH="/opt/homebrew/opt/protobuf@3/bin:$PATH"
export PATH="/opt/homebrew/opt/protobuf@3/bin:$PATH"
