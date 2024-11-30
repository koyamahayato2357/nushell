alias n = nvim
alias g = git
alias l = facad -l
alias nvif = nvim \(fzf)
alias laz = lazygit
alias nvimsudo = sudo -E nvim
alias vivaldi = vivaldi --enable-features=UseOzonePlatform --ozone-platform=wayland
alias man = man --pager='bat -l man -p'
alias fzf = fzf --preview "bat --color=always --style=header,grid --line-range :100 {}"
alias rmf = rm -rf
alias psa = procs
alias cd = z

def --env mkcd [dir: path] {
    mkdir $dir and cd $dir
}

def --env compileasm [fname: string] {
    nasm -f elf64 ($fname + '.asm') -o a.out
    ld a.out -o $fname
    rm a.out
}

def --env ggrks [...queries] {
    w3m -sixel http://www.google.co.jp/search?q=($queries | str join +)
}

def --env launch [...cmd] {
    nohup ($cmd | str join ' ') out+err> /dev/null &
}

def --env extract [fname: path] {
    if ($fname | str ends-with .zip) {
        unzip $fname
    } else if ($fname | str ends-with .tar.gz) {
        tar xzvf $fname
    } else if ($fname | str ends-with .tar.bz2) {
        tar xjvf $fname
    } else {
        ^echo "Unsupported file type:" ($fname | path basename)
    }
}
