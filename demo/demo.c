#include <windows.h>
#include "tcg.h"

void go() {
  MessageBoxA(NULL, "Hello World", "Hello World", MB_OK);
  OutputDebugStringA("Hello World");
}


// Source: https://tradecraftgarden.org/simplepic.html
// Copyright 2025 Raphael Mudge, Adversary Fan Fiction Writers Guild
FARPROC resolve(DWORD modHash, DWORD funcHash) {
  HANDLE hModule = findModuleByHash(modHash);
  return findFunctionByHash(hModule, funcHash);
}

FARPROC resolve_ext(const char* mod, const char* func) {
  HANDLE hModule = GetModuleHandleA(mod);
  if (hModule == NULL)
    hModule = LoadLibraryA(mod);
  return GetProcAddress(hModule, func);
}

__declspec(noinline) ULONG_PTR caller(void) {
  return (ULONG_PTR)WIN_GET_CALLER();
}
