# cp-dfr-defs

This repository contains Crystal Palace's symbol [remap](https://aff-wg.org/2025/10/27/tradecraft-gardens-pic-parterre/) specifications for various Windows libraries to map `Function()` calls to corresponding `MODULE$Function()` calls. Just include the corresponding libraries in your spec file:

```bash
x64:
#...
  run "libntdll.spec"
  run "libkernel32.spec"
  run "libuser32.spec"
  export
```

For an example usage, see [`demo.c`](/demo/demo.c) and [`loader.spec`](/demo/loader.spec).

Alongside individual library remaps, the repository also includes a few *umbrella* remap specs for convenience:

- `dfr_tiny.spec` (771 k): A minimal set of commonly used libraries: Ntdll, Kernel32, and User32.
- `dfr_comprehensive.spec` (1.1 M): A broader collection: Ntdll, Kernel32, User32, Ws2_32, WinHttp, WinInet, Ole32, Rpcrt4, and PsApi.
- `dfr_windows.spec` (6.6M): Everything combined into a single remap specification.
