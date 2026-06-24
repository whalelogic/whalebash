# Bash Parameters and Expansion

| Syntax | Meaning | Example |
|--------|---------|---------|
| `${var:-default}` | Use `default` if unset or empty | `${NAME:-anonymous}` |
| `${var:=default}` | Assign and use `default` if unset or empty | `${TMPDIR:=/tmp}` |
| `${var:?msg}` | Error with `msg` if unset or empty | `${1:?Usage: script.sh ARG}` |
| `${var:+alt}` | Use `alt` if set and non-empty | `${DEBUG:+ --verbose}` |
| `${#var}` | Length of string / array element count | `${#PATH}` |
| `${var^}` | Uppercase first char | `${name^}` |
| `${var^^}` | Uppercase all chars | `${name^^}` |
| `${var,}` | Lowercase first char | `${NAME,}` |
| `${var,,}` | Lowercase all chars | `${NAME,,}` |
| `${var/pat/rep}` | Replace first match of pattern | `${f/.txt/.bak}` |
| `${var//pat/rep}` | Replace all matches | `${str// /_}` |
| `${var#pat}` | Strip shortest prefix matching `pat` | `${path#*/}` |
| `${var##pat}` | Strip longest prefix matching `pat` | `${path##*/}` → filename |
| `${var%pat}` | Strip shortest suffix matching `pat` | `${file%.*}` → no extension |
| `${var%%pat}` | Strip longest suffix matching `pat` | `${url%%/*}` → scheme |
| `${var:offset:len}` | Substring | `${str:0:5}` |
| `${!prefix*}` | Variable names matching prefix | `${!BASH*}` |
| `${!arr[@]}` | Keys/indices of array | `${!mymap[@]}` |
