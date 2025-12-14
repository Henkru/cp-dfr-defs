#!/bin/sh

if [ $# -lt 1 ]; then
    echo "Usage: $0 <lib path> ..." >&2
    exit 1
fi

remap64=`mktemp` || exit 1
remap86=`mktemp` || exit 1
echo "x64:" > $remap64
echo "x86:" > $remap86

for f in "$@"; do
  base=${f##*/}
  dll=${base#lib}
  dll=${dll%.a}

  remaps=$(nm "$f" 2>/dev/null | awk -v dll="$dll" '
    /__imp_/ {
        line = $0
        if (match(line, /(__imp__?)(.*)/, arr)) {
            prefix = arr[1]
            rest = arr[2]
            name = prefix dll "$" rest
            print "  remap \"" arr[0] "\" \"" name "\""
        }
    }
  ')

  while IFS= read -r line; do 
    case "$line" in
      *__imp__*) echo "  $line" >> $remap86 ;;
      *)         echo "  $line" >> $remap64 ;;
    esac
  done <<< "$remaps"
done

cat $remap64 $remap86
rm $remap86 $remap64
