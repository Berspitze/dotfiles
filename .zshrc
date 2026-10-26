# --  Environment --
export EDITOR="nvim"
export VISUAL="$EDITOR"

export PAGER="less"
export LESS="-R"

# -- Completion --
# Docker CLI completions
fpath=("$HOME/.docker/completions" $fpath)

autoload -Uz compinit
compinit -d "$HOME/.cache/zsh/zcompdump"

# -- Shell Options --
setopt AUTOCD
setopt EXTENDEDGLOB

# History
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

HISTSIZE=5000
SAVEHIST=5000
HISTFILE="$HOME/.zsh_history"

# -- PATH --
# Keep PATH entries unique
typeset -U path PATH

# Homebrew environment
eval "$(/opt/homebrew/bin/brew shellenv)"

# User binaries and development tools
path=(
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "$HOME/.local/share/nvim/mason/bin"
  "$HOME/.opencode/bin"
  /opt/homebrew/opt/bison/bin
  /opt/homebrew/opt/flex/bin
  /opt/homebrew/opt/openjdk/bin
  /Applications/Obsidian.app/Contents/MacOS
  $path
)

# -- Python --
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init - zsh)"
fi

# -- Java / Scala --
# export JAVA_HOME="/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home"
export JAVA_HOME=$(/usr/libexec/java_home -v 21)
export PATH="$JAVA_HOME/bin:$PATH"

# -- macOS / Build Tools --
export LDFLAGS="-L/opt/homebrew/lib"
export CPPFLAGS="-I/opt/homebrew/include"

# -- Application State / History Files --
export TERMINFO="$HOME/.config/.terminfo"
export LESSHISTFILE="$HOME/.cache/less/history"
export SQLITE_HISTORY="$HOME/.cache/sqlite/history"

# -- Aliases --
alias ls='ls -G --color=auto'
# alias ll='ls -lah'
alias grep='grep --color=auto'

alias rmusic='yt-dlp -f "bestaudio" --extract-audio --audio-format flac --audio-quality 0 -P "$HOME/Music/mpd/"'
alias dtwt='npx twt-dl-cli@latest'
alias wgetpage='wget --mirror --convert-links --adjust-extension --page-requisites --no-parent'
alias glow='glow -p'
alias yt-mp4='yt-dlp -f "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]" --merge-output-format mp4'

# -- Git Prompt --
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats '(%b) '

precmd() {
  vcs_info
}

setopt PROMPT_SUBST

# -- Terminal Colors --
hex_color() {
  local hex="${1#\#}"

  printf '\e[38;2;%d;%d;%dm' \
    "$((16#${hex[1,2]}))" \
    "$((16#${hex[3,4]}))" \
    "$((16#${hex[5,6]}))"
}

# Earth palette
COLOR_TIME=$(hex_color "#506b54")
COLOR_USER=$(hex_color "#9bbfa3")
COLOR_PATH=$(hex_color "#dce3d8")
COLOR_VCS=$(hex_color "#c1121f")

RESET=$'\e[0m'

# Prompt: time  user  current directory  git branch
PROMPT="%{${COLOR_TIME}%}%*%{${RESET}%} %{${COLOR_USER}%}%n%{${RESET}%} %{${COLOR_PATH}%}%1~%{${RESET}%} %{${COLOR_VCS}%}\${vcs_info_msg_0_}%{${RESET}%}$ "

# -- Keybindings --
bindkey '^K' up-line-or-history
bindkey '^J' down-line-or-history
bindkey '^A' beginning-of-line
