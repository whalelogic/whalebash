# Bash Syntax Reference


```markdown
| Name | Category | Description | Example / Notes |
|------|----------|-------------|-----------------|
| `$0` | Special Variable | Name of the script or shell | `echo $0` → `bash` or `./script.sh` |
| `$1`–`$9` | Special Variable | Positional parameters (arguments) | `$1` is first arg, `$9` is ninth |
| `${10}`, `${11}`, … | Special Variable | Positional parameters ≥10 (must use braces) | `echo ${10}` |
| `$#` | Special Variable | Number of positional parameters | `if [[ $# -lt 2 ]]; then ...` |
| `$@` | Special Variable | All positional params as separate words | `for arg in "$@"; do ...` — preserves quoting |
| `$*` | Special Variable | All positional params as a single word | IFS-joined when quoted: `"$*"` → `"a b c"` |
| `$?` | Special Variable | Exit status of last command | `0` = success, non-zero = failure |
| `$$` | Special Variable | PID of current shell | Useful for temp files: `/tmp/work.$$` |
| `$!` | Special Variable | PID of last background job | `sleep 10 & echo $!` |
| `$-` | Special Variable | Current shell option flags | `echo $-` → `himBHs` etc. |
| `$_` | Special Variable | Last argument of previous command | `mkdir /tmp/foo && cd $_` |
| `IFS` | Environment Variable | Internal Field Separator | Default: space, tab, newline |
| `PATH` | Environment Variable | Colon-separated command search path | `export PATH="$HOME/bin:$PATH"` |
| `HOME` | Environment Variable | Current user's home directory | `cd $HOME` or just `cd` |
| `PWD` | Environment Variable | Present working directory | Updated by `cd` |
| `OLDPWD` | Environment Variable | Previous working directory | `cd -` uses this |
| `SHELL` | Environment Variable | Path to current shell binary | `/bin/bash` |
| `USER` / `LOGNAME` | Environment Variable | Current username | `echo $USER` |
| `HOSTNAME` | Environment Variable | Machine hostname | `echo $HOSTNAME` |
| `UID` | Environment Variable | User ID (read-only) | `0` = root |
| `EUID` | Environment Variable | Effective user ID | May differ from `UID` with `sudo` |
| `GROUPS` | Environment Variable | Array of group IDs for current user | `echo ${GROUPS[@]}` |
| `BASH` | Environment Variable | Full path to bash binary | `/usr/bin/bash` |
| `BASH_VERSION` | Environment Variable | Version string | `5.2.15(1)-release` |
| `BASH_VERSINFO` | Environment Variable | Array of version components | `${BASH_VERSINFO[0]}` = major |
| `BASHPID` | Environment Variable | PID of current bash process (subshell-aware) | Differs from `$$` in subshells |
| `PPID` | Environment Variable | PID of parent process | `echo $PPID` |
| `SHLVL` | Environment Variable | Shell nesting level | `1` = login shell, increments on subshells |
| `LINENO` | Environment Variable | Current line number in script | For debugging |
| `FUNCNAME` | Environment Variable | Array of function call stack names | `${FUNCNAME[0]}` = current function |
| `BASH_SOURCE` | Environment Variable | Array of source filenames for call stack | Pairs with `FUNCNAME` |
| `BASH_LINENO` | Environment Variable | Array of line numbers in call stack | `${BASH_LINENO[0]}` = caller's line |
| `RANDOM` | Environment Variable | Random integer 0–32767 each read | `echo $((RANDOM % 100))` |
| `SECONDS` | Environment Variable | Seconds since shell started (assignable) | `echo $SECONDS` |
| `TMOUT` | Environment Variable | Auto-logout timeout in seconds | `TMOUT=600` logs out after 10 min idle |
| `HISTFILE` | Environment Variable | Path to history file | Default `~/.bash_history` |
| `HISTSIZE` | Environment Variable | Max commands in memory history | Default 500 or 1000 |
| `HISTFILESIZE` | Environment Variable | Max lines saved to `HISTFILE` | |
| `HISTCONTROL` | Environment Variable | Controls history deduplication | `ignoredups`, `ignorespace`, `erasedups` |
| `HISTIGNORE` | Environment Variable | Colon-separated patterns to omit | `HISTIGNORE="ls:cd:exit"` |
| `PROMPT_COMMAND` | Environment Variable | Command run before each `PS1` prompt | `PROMPT_COMMAND='echo -n "[$(date +%H:%M)]"'` |
| `PS1` | Environment Variable | Primary prompt string | `\u@\h:\w\$` |
| `PS2` | Environment Variable | Continuation prompt (multiline input) | Default `>` |
| `PS3` | Environment Variable | `select` loop prompt | |
| `PS4` | Environment Variable | `xtrace` (`set -x`) prompt prefix | Default `+`; set to `'${BASH_SOURCE}:${LINENO}: '` for debug |
| `REPLY` | Environment Variable | Default variable for `read` and `select` | `read` without `-r` uses this |
| `OPTARG` | Environment Variable | Argument value for current `getopts` option | |
| `OPTIND` | Environment Variable | Index of next `getopts` argument | Reset to 1 before reusing `getopts` |
| `PIPESTATUS` | Environment Variable | Array of exit statuses from last pipeline | `ls | grep x | wc`; `${PIPESTATUS[@]}` |
| `MAPFILE` / `READARRAY` | Environment Variable | Default array name for `mapfile` built-in | |
| `COMP_WORDS` | Environment Variable | Array of words on current completion command line | Used in completion functions |
| `COMP_CWORD` | Environment Variable | Index into `COMP_WORDS` of cursor position | |
| `COMPREPLY` | Environment Variable | Array of completion candidates | Set by completion functions |
| `DIRSTACK` | Environment Variable | Array of `pushd`/`popd` directory stack | `${DIRSTACK[@]}` |
| `GLOBIGNORE` | Environment Variable | Colon-separated patterns to exclude from glob | `GLOBIGNORE='*.o:*.a'` |
| `CDPATH` | Environment Variable | Colon-separated paths `cd` searches | `CDPATH=.:~:~/projects` |
| `MAILCHECK` | Environment Variable | Seconds between mail checks | Default 60 |
| `TIMEFORMAT` | Environment Variable | Format string for `time` output | `TIMEFORMAT='real=%R user=%U'` |
| `LANG` / `LC_*` | Environment Variable | Locale settings | `LANG=en_US.UTF-8` |
| `TERM` | Environment Variable | Terminal type | `xterm-256color` |
| `COLUMNS` / `LINES` | Environment Variable | Terminal width/height (auto-updated) | `echo $COLUMNS` |
| `:` | Built-in | No-op; always succeeds (exit 0) | `while :; do ...` for infinite loop |
| `.` (dot) | Built-in | Source a file in current shell | `. ~/.bashrc` (same as `source`) |
| `source` | Built-in | Source a file (synonym for `.`) | `source ~/.bashrc` |
| `alias` | Built-in | Define or display aliases | `alias ll='ls -la'` |
| `unalias` | Built-in | Remove an alias | `unalias ll` |
| `echo` | Built-in | Print text to stdout | `echo -e "line1\nline2"` |
| `printf` | Built-in | Formatted output (like C printf) | `printf '%s\t%d\n' name 42` |
| `read` | Built-in | Read a line from stdin into variable(s) | `read -rp "Name: " name` |
| `readarray` / `mapfile` | Built-in | Read lines from stdin into an array | `mapfile -t arr < file.txt` |
| `cd` | Built-in | Change working directory | `cd -` returns to `$OLDPWD` |
| `pwd` | Built-in | Print working directory | `pwd -P` resolves symlinks |
| `pushd` | Built-in | Push directory onto stack and cd | `pushd ~/projects` |
| `popd` | Built-in | Pop directory from stack and cd | |
| `dirs` | Built-in | Display directory stack | `dirs -v` numbered |
| `exit` | Built-in | Exit shell with status | `exit 1` |
| `return` | Built-in | Return from a function or sourced file | `return 0` |
| `exec` | Built-in | Replace shell with command (no fork) | `exec python3 script.py` |
| `eval` | Built-in | Evaluate string as shell command | `eval "echo \$var"` — use with caution |
| `export` | Built-in | Mark variable/function for export to env | `export PATH` |
| `unset` | Built-in | Delete variable or function | `unset myvar` |
| `declare` / `typeset` | Built-in | Declare variables with attributes | `declare -i n=5; declare -a arr` |
| `local` | Built-in | Declare local variable inside function | `local x=10` |
| `readonly` | Built-in | Make variable read-only | `readonly PI=3.14159` |
| `let` | Built-in | Arithmetic evaluation | `let x=2+3; let "x *= 2"` |
| `set` | Built-in | Set/display shell options and positional params | `set -euo pipefail` |
| `shopt` | Built-in | Set/display bash-specific options | `shopt -s extglob nullglob globstar` |
| `getopts` | Built-in | Parse option flags in scripts | `while getopts "abc:" opt; do ...` |
| `shift` | Built-in | Shift positional parameters left | `shift 2` removes `$1` and `$2` |
| `test` / `[` | Built-in | Evaluate conditional expression | `test -f file` or `[ -f file ]` |
| `[[` | Built-in (keyword) | Extended conditional expression | `[[ $x =~ ^[0-9]+$ ]]` — no word-splitting |
| `(( ))` | Built-in (keyword) | Arithmetic conditional / evaluation | `(( x > 5 ))` returns exit status |
| `true` | Built-in | Always exits 0 | Used in `while true; do ...` |
| `false` | Built-in | Always exits 1 | |
| `type` | Built-in | Show how a name is interpreted | `type ll` → `ll is aliased to 'ls -la'` |
| `which` | External (often) | Find command in PATH | `which python3` |
| `command` | Built-in | Bypass aliases/functions, run command directly | `command ls` ignores `ls` alias |
| `builtin` | Built-in | Invoke a built-in directly | `builtin cd /tmp` |
| `enable` | Built-in | Enable/disable built-in commands | `enable -n echo` |
| `help` | Built-in | Show help for built-ins | `help read` |
| `hash` | Built-in | Remember / display command paths | `hash -r` clears cache |
| `history` | Built-in | Display/manage command history | `history 20`, `history -c` |
| `fc` | Built-in | Fix command (edit history entries) | `fc -l` lists recent, `fc` opens editor |
| `jobs` | Built-in | List active jobs | `jobs -l` with PIDs |
| `bg` | Built-in | Resume job in background | `bg %1` |
| `fg` | Built-in | Bring job to foreground | `fg %1` |
| `wait` | Built-in | Wait for job/PID to complete | `wait $!` |
| `kill` | Built-in | Send signal to process | `kill -TERM $pid` |
| `disown` | Built-in | Remove job from job table | `disown %1` prevents SIGHUP |
| `suspend` | Built-in | Suspend the shell | `suspend` (not valid in login shell) |
| `trap` | Built-in | Register signal/event handlers | `trap 'cleanup' EXIT INT TERM` |
| `times` | Built-in | Show CPU times for shell and children | `times` |
| `ulimit` | Built-in | Set/display resource limits | `ulimit -n 65536` (open files) |
| `umask` | Built-in | Set/display file creation mask | `umask 022` |
| `bind` | Built-in | Bind key sequences (readline) | `bind '"\C-p": history-search-backward'` |
| `complete` | Built-in | Specify completion for commands | `complete -F _myfunc mycommand` |
| `compgen` | Built-in | Generate completion matches | `compgen -W "foo bar baz" -- "$cur"` |
| `compopt` | Built-in | Modify completion options | `compopt -o filenames` |
| `caller` | Built-in | Return call stack info | `caller 0` → `lineno func file` |
| `mapfile` | Built-in | Read lines into indexed array | `mapfile -t lines < input.txt` |
| `coproc` | Built-in (keyword) | Create a coprocess (async pipe) | `coproc my_proc { cmd; }` |
| `time` | Built-in (keyword) | Time a pipeline | `time find / -name "*.log"` |
| `function` | Built-in (keyword) | Define a function | `function greet { echo "Hi $1"; }` |
| `if`/`then`/`else`/`elif`/`fi` | Keyword | Conditional branching | Standard control flow |
| `for`/`in`/`do`/`done` | Keyword | Iteration | `for f in *.txt; do ...; done` |
| `while`/`until` | Keyword | Loop while/until condition | `while read -r line; do ...; done` |
| `case`/`in`/`esac` | Keyword | Pattern-matching branch | `case $1 in start) ...; stop) ...; esac` |
| `select` | Keyword | Interactive menu loop | `select opt in foo bar; do ...; done` |
| `break` | Built-in | Exit loop | `break 2` breaks 2 levels |
| `continue` | Built-in | Skip to next loop iteration | `continue 2` skips 2 levels |
```
