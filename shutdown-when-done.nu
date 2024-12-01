def --env shutdown-when-done [
    --pid (-p): int,
	--name (-n): string
] {
    if $pid == 0 and $name == "" or $pid != 0 and $name != "" {
        ^echo "Usage: (-p <int>|-n <string>)"
		return 1
	}

	if $pid != 0 {
        wait-for-process-done pid $pid
	} else {
        wait-for-process-done name $name
	}

	shutdown now
}

def --env wait-for-process-done [type: string, value: any] {
	let val = match $type {
		"pid" => ($value | into int),
		"name" => ($value | into string)
	}

    while (ps | find $val | is-not-empty) {
        sleep 10sec
	}
}
