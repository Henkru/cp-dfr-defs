#!/bin/bash
set -eu

if [ $# -lt 1 ]; then
    echo "Usage: $0 <library_name1> [library_name2 ...]" >&2
    exit 1
fi

LIBS=("$@")
SCRIPT_DIR=$(dirname "$(realpath "$0")")
REMAP_SCRIPT="$SCRIPT_DIR/cf-remap.sh"

if [ ! -x "$REMAP_SCRIPT" ]; then
    echo "[-] External script '$REMAP_SCRIPT' not found or not executable." >&2
    exit 1
fi

X86_COMPILER="i686-w64-mingw32-gcc"
X64_COMPILER="x86_64-w64-mingw32-gcc"

get_lib_paths() {
    local COMPILER=$1
    $COMPILER -print-search-dirs | grep "^libraries:" | sed 's/libraries: =//' | tr ':' '\n'
}

search_library() {
    local LIBNAME=$1
    local COMPILER=$2

    paths=$(get_lib_paths $COMPILER)
    results=()

    for path in $paths; do
        norm_path=$(realpath -m "$path")
        for file in "$norm_path/lib$LIBNAME.a" "$norm_path/$LIBNAME.lib"; do
            if [ -f "$file" ]; then
                results+=("$file")
            fi
        done
    done

    printf "%s\n" "${results[@]}" | sort -u
}

ALL_FOUND_LIBS=()

for LIB in "${LIBS[@]}"; do
    echo "[+] Searching for '$LIB'..." >&2

    X86_LIBS=$(search_library "$LIB" $X86_COMPILER)
    X64_LIBS=$(search_library "$LIB" $X64_COMPILER)

    if [ -n "$X86_LIBS" ]; then
        echo "$X86_LIBS" | while read f; do
            echo "  x86: $f" >&2
        done
        ALL_FOUND_LIBS+=($X86_LIBS)
    fi

    if [ -n "$X64_LIBS" ]; then
        echo "$X64_LIBS" | while read f; do
            echo "  x64: $f" >&2
        done
        ALL_FOUND_LIBS+=($X64_LIBS)
    fi

    if [ -z "$X86_LIBS" ] && [ -z "$X64_LIBS" ]; then
        echo "[-] Library '$LIB' not found" >&2
        exit 1
    fi
done

# Remove duplicates
ALL_FOUND_LIBS=($(printf "%s\n" "${ALL_FOUND_LIBS[@]}" | sort -u))

if [ ${#ALL_FOUND_LIBS[@]} -gt 0 ]; then
    echo "[+] Generating the remap spec" >&2
    "$REMAP_SCRIPT" "${ALL_FOUND_LIBS[@]}"
else
    echo "[-] No libraries found to pass to the remapper script." >&2
    exit 1
fi
