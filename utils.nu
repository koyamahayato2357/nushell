def env-exist [var: string] {
	$env | find $var | is-not-empty
}
