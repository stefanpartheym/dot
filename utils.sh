prompt() {
	prompt_string="$1"
	default_value="$2"
	if test -n "$default_value"; then
		prompt_string="$prompt_string [$default_value]"
	fi
	read -p "${prompt_string}: " input
	if test -z "$input"; then
		input=$default_value
	fi

	echo "$input"
}
