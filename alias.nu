alias n = nvim
alias g = git
alias l = ls -adlt
alias nvif = nvim \(fzf)
alias laz = lazygit
alias nvimsudo = sudo -E nvim
alias vivaldi = vivaldi --enable-features=UseOzonePlatform --ozone-platform=wayland
alias man = man --pager='bat -l man -p'
alias fzf = tv
alias rmf = rm -rf
alias psa = procs
alias ffcmd = cat $nu.history-path | sed 's/ \+$//' | ^sort -u | tv

def --env mkcd [dir: path] {
    mkdir $dir
	cd $dir
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
        ^echo "Unsupported file type:" ($fname | path parse | get extension)
    }
}

def --env zs [path: string] {
	let actual_path = (zoxide query $path)
	nvim --server $env.NVIM --remote-send $"<cmd>cd ($actual_path)<CR>"
	cd $actual_path
	zoxide add .
}
