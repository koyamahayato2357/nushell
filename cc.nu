def --env cc [--type (-t): string = "debug", ...files: path] {
    let cwd_contents = (ls | get name)
	if ($cwd_contents | find makefile | is-not-empty) {
        make
	} else if ($cwd_contents | find build.zig | is-not-empty) {
		zig build
	} else if ($cwd_contents | find cargo.toml | is-not-empty) {
        cargo build
	}
}
