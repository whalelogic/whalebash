# Arrays

| Operation | Indexed Array | Associative Array |
|-----------|--------------|-------------------|
| Declare | `declare -a arr` | `declare -A map` |
| Assign all | `arr=(a b c)` | `map=([k1]=v1 [k2]=v2)` |
| Assign one | `arr[2]=x` | `map[key]=val` |
| Read one | `${arr[2]}` | `${map[key]}` |
| All values | `${arr[@]}` | `${map[@]}` |
| All keys/indices | `${!arr[@]}` | `${!map[@]}` |
| Length (elements) | `${#arr[@]}` | `${#map[@]}` |
| Length of element | `${#arr[2]}` | `${#map[key]}` |
| Slice | `${arr[@]:1:3}` | N/A |
| Append element | `arr+=(d e)` | `map[new]=val` |
| Delete element | `unset 'arr[2]'` | `unset 'map[key]'` |
| Delete all | `unset arr` | `unset map` |
| Iterate | `for v in "${arr[@]}"` | `for k in "${!map[@]}"` |

