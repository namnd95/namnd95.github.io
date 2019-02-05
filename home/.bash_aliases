function ssh_add() {
	setopt shwordsplit &>/dev/null

	# load agent if it's not running
	if [ -z "$SSH_AUTH_SOCK" ]; then
		eval $(ssh-agent) &>/dev/null
	fi
	
	local key=$HOME/.ssh/id_rsa
	ssh-add -l >/dev/null || ssh-add $key
}

function ssh() {
	ssh_add
	command ssh "$@"
}
function scp() {
	ssh_add
	command scp "$@"
}
function rsync() {
	ssh_add
	command rsync "$@"
}
function git() {
	case $1 in
		push|pull|fetch|clone)
			ssh_add
			;;
	esac

	command git "$@"
}


export VISUAL=vim
export EDITOR=vim

