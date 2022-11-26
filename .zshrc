# start speed benchmark
# zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/chujiani/.zshrc'

autoload -Uz compinit
compinit
# End of lines configured by coninstall

# enable powerlevel10k
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# auto suggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# history-substring-search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# miniconda
source /opt/miniconda/etc/profile.d/conda.sh
# conda activate chujiani

# proxy
export http_proxy=http://127.0.0.1:7890/
export https_proxy=http://127.0.0.1:7890/

# alias
alias ls="ls --color=auto"
alias la="ls -a "
alias ll="ls -la "

# key bindings
typeset -g -A key
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         history-substring-search-up
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       history-substring-search-down
[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# accelerate yadm auto-complete
__git_files () { 
    _wanted files expl 'local files' _files     
}

