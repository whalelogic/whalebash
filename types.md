# Bash Types Reference


| Type / Attribute | `declare` Flag | How to Create | Behavior & Notes | Example |
|------------------|----------------|---------------|------------------|---------|
| **String** (default) | *(none)* | `var="hello"` | Default type for all assignments; everything is a string unless flagged | `name="Alice"` |
| **Integer** | `-i` | `declare -i n=5` | Arithmetic auto-evaluated on assignment; non-numeric strings assign `0` | `declare -i x; x="3*4"` → `x=12` |
| **Indexed Array** | `-a` | `declare -a arr` or `arr=(...)` | Zero-based integer indices; sparse allowed | `arr=(a b c); echo ${arr[1]}` → `b` |
| **Associative Array** | `-A` | `declare -A map` | String keys; requires `declare -A` | `declare -A d; d[foo]=bar; echo ${d[foo]}` |
| **Read-only** | `-r` | `declare -r` or `readonly` | Prevents reassignment or unsetting | `readonly PI=3.14159` |
| **Exported** | `-x` | `declare -x` or `export` | Passed to child processes as environment variable | `export PATH` |
| **Function** | `-f` / `-F` | `function name { }` or `name(){}` | `-f` shows definition; `-F` shows names only | `declare -F` lists all functions |
| **Nameref** | `-n` | `declare -n ref=target` | Reference (alias) to another variable by name | `declare -n ptr=myvar; ptr=42` sets `myvar=42` |
| **Lowercase** | `-l` | `declare -l var` | Value auto-converted to lowercase on assignment | `declare -l s; s="HELLO"` → `s="hello"` |
| **Uppercase** | `-u` | `declare -u var` | Value auto-converted to uppercase on assignment | `declare -u s; s="hello"` → `s="HELLO"` |
| **Trace** | `-t` | `declare -t` | Triggers `DEBUG` trap on function calls | Rarely used; useful in advanced debuggers |
| **Local** | via `local` | `local var=val` (inside functions only) | Scope limited to function and its callees | `local tmp=$(mktemp)` |
| **Scalar (untyped)** | *(default)* | Any `var=val` without declare | No special attribute; behaves as string; arithmetic via `$((...))` or `let` | `x=5; echo $((x+1))` |
| **Null / Unset** | — | `unset var` | Unset variables expand to empty string by default; detectable with `[[ -v var ]]` | `unset myvar; echo ${myvar:-default}` |
| **Empty String** | — | `var=""` | Variable is set but empty; distinct from unset under `set -u` / `${var:?}` | `var=""; [[ -z $var ]]` → true |

