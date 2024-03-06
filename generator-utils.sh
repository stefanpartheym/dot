function prompt {
	read_args=""
	read_prompt=""

	if [ -n "$2" ]; then
		read_args="-p"
		read_prompt="$2"
		if [ -n "$3" ]; then
			read_prompt="$read_prompt[$3] "
		fi
	fi

	read $read_args "$read_prompt" $1

	if [ -n "$3" ] && [ -z "${!1}" ]; then
		eval "${1}=\"${3}\""
	fi
}

function replace {
	echo "${1//\{\{$2\}\}/$3}"
}
