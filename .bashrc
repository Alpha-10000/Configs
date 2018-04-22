#Clone current directory while opening new terminal
#PROMPT_COMMAND is executed before each first prompt of a terminal
PROMPT_COMMAND='pwd > "${HOME}/.curdir"'
#Check if file has ben created, and change to previously saved directory
test -f "${HOME}/.curdir" && cd "$(< ${HOME}/.curdir)"

alias emacs='emacs -nw'
alias gdb='gdb -q'

alias i3lock='i3lock -c 141517'
alias ls='ls --color'

alias alsa='alsamixer'
alias scrot='scrot -s'

alias checkpatch='/path/to/checkpatch.pl --strict --ignore FILE_PATH_CHANGES'

pushd()
{
    if [ $# -eq 0 ]; then
	DIR="${HOME}"
    else
	DIR="$1"
    fi
    builtin pushd "${DIR}" > /dev/null
}
popd() { builtin popd > /dev/null; }
alias cd='pushd'
alias ..='cd ..'
alias -- -='cd -'
alias p='popd'

export LC_ALL=en_US.UTF-8
