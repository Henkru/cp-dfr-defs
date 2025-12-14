x64:
    push $OBJECT
        make pic +optimize +gofirst

        # This demo is using the winapi resolver from TCG
        mergelib "libtcg.x64.zip"
        dfr "resolve" "ror13" "KERNEL32, NTDLL"
        dfr "resolve_ext" "strings"

        # Apply the DFR remap
        run "../dfr_windows.spec"

        export

x86:
    push $OBJECT
        make pic +optimize +gofirst

        # This demo is using the winapi resolver from TCG
        mergelib "libtcg.x86.zip"
        fixptrs "_caller"
        dfr "_resolve" "ror13" "KERNEL32, NTDLL"
        dfr "_resolve_ext" "strings"

        # Apply the DFR remap
        run "../dfr_windows.spec"

        export
