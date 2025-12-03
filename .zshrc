HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

export EDITOR=nvim
export BROWSER=firefox

alias ll='ls -alhF'
alias h='hyprland'
alias o='xdg-open'
alias k='kubectl'

alias dc='docker-compose'
alias dcs='dc ps'
alias dcu='dc up -d'
alias dcd='dc down'
alias dcl='dc logs -f --tail=50'

setopt autocd
unsetopt beep
zstyle :compinstall filename '/home/magnus/.zshrc'

autoload -Uz compinit promptinit
compinit

promptinit
fpath=("$HOME/.zprompts" "$fpath[@]")
prompt walters


##
## ssh-agent
##

if [[ $(uname) == "Darwin" ]]; then
	export GPG_TTY="$(tty)"
	export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
	gpgconf --launch gpg-agent
else
	if ! pgrep -u "$USER" ssh-agent > /dev/null; then
	    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
	fi
	if [ ! -f "$SSH_AUTH_SOCK" ]; then
	    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
	fi
fi

if command -v fzf > /dev/null; then
	source <(fzf --zsh)
fi

if command -v tmuxifier > /dev/null; then
	eval "$(tmuxifier init -)"
fi

if command -v xdg-user-dir > /dev/null; then
	source "$HOME/.config/user-dirs.dirs"
fi

if [ -e /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export HOMEBREW_CASK_OPTS="--appdir=$HOME/Applications"
fi

if [ -e /opt/homebrew/opt/nvm/nvm.sh ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
fi

# fzf-zsh-plugin
if [ -e "$HOME/.plugins/fzf-zsh-plugin/fzf-zsh-plugin.plugin.zsh" ]; then
  export PATH="$PATH:$HOME/.plugins/fzf-zsh-plugin/bin"
  source "$HOME/.plugins/fzf-zsh-plugin/fzf-zsh-plugin.plugin.zsh"
  alias b='fzf-git-checkout'
fi

##
## Key bindings
##

bindkey -v
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-beginning-search
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-beginning-search
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi


###
### Launch tmux

#if [ $(command -v tmux) ] && [ -n "$GHOSTTY_BIN_DIR" ] && [ -z "$TMUX" ]; then
#  tmux attach-session -t default || tmux new-session -s default
#fi

