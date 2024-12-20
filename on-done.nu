def --env on-done [
	callback: closure,
    --pid (-p): int = 0,
	--name (-n): string = ""
] {
    if $pid == 0 and $name == "" or $pid != 0 and $name != "" {
        ^echo "Usage: (-p <int>|-n <string>)"
		return 1
	}

	if $pid != 0 {
        wait-for-process-done-with-pid $pid
	} else {
        wait-for-process-done-with-name $name
	}

	do $callback
}

def wait-for-process-done-with-pid [pid: int] {
	while (ps | get pid | find $pid | is-not-empty) {
		sleep 10sec
	}
}

def wait-for-process-done-with-name [name: string] {
	while (ps | get name | find $name | is-not-empty) {
		sleep 10sec
	}
}
