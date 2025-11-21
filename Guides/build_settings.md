## Which clang version is use

There are multiple clang version in the workspace, located at `android/prebuilts/clang/host/linux-x86/`.
To check which version is used, check the file `android/build/soong/cc/config/global.go`

```
	// prebuilts/clang default settings.
	ClangDefaultBase         = "prebuilts/clang/host"
	ClangDefaultVersion      = "clang-r522817"
	ClangDefaultShortVersion = "18"
```

