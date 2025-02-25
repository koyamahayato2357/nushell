alias g = git
alias l = ls -adlt
alias nvif = nvim \(fzf)
alias nvimsudo = sudo -E nvim
alias vivaldi = vivaldi --enable-features=UseOzonePlatform --ozone-platform=wayland
alias fzf = tv
alias rmf = rm -rf
alias psa = procs
alias ffcmd = cat $nu.history-path | sed 's/ \+$//' | ^sort -u | tv

def --env mkcd [dir: path] {
    mkdir $dir
	cd $dir
}

def compileasm [fname: string] {
    nasm -f elf64 ($fname + '.asm') -o a.out
    ld a.out -o $fname
    rm a.out
}

def ggrks [...queries] {
    w3m -sixel http://www.google.co.jp/search?q=($queries | str join +)
}

def extract [fname: path] {
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

def --env is-nvim-running [] {
	"NVIM" in $env
}

def --env send-to-nvim-cmd [cmd: string, --strict = false] {
    if (is-nvim-running) {
		nvim --server $env.NVIM --remote-send $cmd
	} else {
		if not $strict { return }
		error make { msg: "Neovim is not running" }
	}
}

def --env n [...rest: string] {
	if (is-nvim-running) {
		send-to-nvim-cmd $"<cmd>tabe ($rest | str join ' ')<CR>"
		return
	}
	nvim ($rest | str join ' ')
}

def --env z [...rest: string] {
    let arg0 = ($rest | append '~').0
    let path = if (($rest | length) <= 1) and ($arg0 == '-' or ($arg0 | path expand | path type) == dir) {
      $arg0
    } else {
      (zoxide query --exclude $env.PWD -- ...$rest | str trim -r -c "\n")
    }
	if ($path | is-empty) { error make { msg: $"No matching directory for: ($rest)" } }
	send-to-nvim-cmd $"<cmd>cd ($path)<CR>"
	cd $path
	zoxide add .
}

def zi [...rest: string] {
    let path = (zoxide query --interactive -- ...$rest | str trim -r -c "\n")
	send-to-nvim-cmd $"<cmd>cd ($path)<CR>"
	cd $path
	zoxide add .
}

def --env laz [] {
	if (is-nvim-running) {
		send-to-nvim-cmd "<cmd>L<CR>"
	} else {
		lazygit
	}
}

def batman [...rest: string] {
	man ...$rest | bat -p -l man
}

def normalize-history [] {
	open $nu.history-path
	| tr -s ' '
	| str replace --all --regex ' $' ''
	| lines | reverse | uniq | reverse
	| save -f $nu.history-path
}

def asm-test [file: path] {
	clang -O3 -march=native -masm=intel -S -o- $file
}

def llvm-test [file: path] {
	clang -O3 -march=native -masm=intel -S -o- -emit-llvm $file
}
