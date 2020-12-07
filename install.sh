#!/usr/bin/env bash

Color_off='\033[0m'       # Text Reset
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow

msg() {
    printf '%b\n' "$1" >&2
}

success() {
    msg "${Green}[✔]${Color_off} ${1}${2}"
}

warn () {
    msg "${Yellow}[⚠]${Color_off} ${1}${2}"
}


#配置VIM
install_vim () {
    if [[ -f "$HOME/.vimrc" ]]; then
        mv "$HOME/.vimrc" "$HOME/.vimrc_back"
        success "Backup $HOME/.vimrc to $HOME/.vimrc_back"
    fi

    if [[ -d "$HOME/.vim" ]]; then
        if [[ "$(readlink $HOME/.vim)" =~ \.vimconfig$ ]]; then
            success "Installed vimconfig for vim"
        else
            mv "$HOME/.vim" "$HOME/.vim_back"
            success "BackUp $HOME/.vim to $HOME/.vim_back"
            ln -s "$HOME/.vimconfig" "$HOME/.vim"
            success "Installed SpaceVim for vim"
        fi
    else
        ln -s "$HOME/.vimconfig" "$HOME/.vim"
        success "Installed SpaceVim for vim"
    fi
}

#配置Neovim
install_neovim () {
    if [[ -d "$HOME/.config/nvim" ]]; then
        if [[ "$(readlink $HOME/.config/nvim)" =~ \.vimconfig$ ]]; then
            success "Installed vimconfig for neovim"
        else
            mv "$HOME/.config/nvim" "$HOME/.config/nvim_back"
            success "BackUp $HOME/.config/nvim to $HOME/.config/nvim_back"
            ln -s "$HOME/.vimconfig" "$HOME/.config/nvim"
            success "Installed vimconfig for neovim"
        fi
    else
        mkdir -p "$HOME/.config"
        ln -s "$HOME/.vimconfig" "$HOME/.config/nvim"
        success "Installed vimconfig for neovim"
    fi
}


main(){
	if hash "vim" &>/dev/null; then
        is_vim8=$(vim --version | grep "Vi IMproved 8")
        is_vim74=$(vim --version | grep "Vi IMproved 7.4")
        if [ -n "$is_vim8" ]; then
            success "Check Requirements: vim 8.0"
						install_vim
        else
            warn "myconfig need vim 8.0 or above"
        fi
        if hash "nvim" &>/dev/null; then
            success "Check Requirements: nvim"
						install_neovim
        fi
	else
        if hash "nvim" &>/dev/null; then
            success "Check Requirements: nvim"
						install_neovim
        else
            warn "Check Requirements : vim or nvim"
        fi
    fi

}

main $@

