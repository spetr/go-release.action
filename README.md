# Go Release Binary GitHub Action

Automate publishing Go build artifacts for GitHub releases through GitHub Actions.

Detects a build.sh in the go repo and will use that instead.  Expects a list of
file artifacts in a single, space delimited line as output for packaging.

Extra environment variables:
* CMD_PATH
  * Pass extra commands to go build
* EXTRA_FILES
  * Pass a list of extra files for packaging.
    * Example: EXTRA_FILES: "README.md LICENSE"

```yaml
# .github/workflows/release.yaml

on: release
name: Build Release
jobs:
  release-linux-386:
    name: release linux/386
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: compile and release
      uses: spetr/go-release.action@v1.0.3
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        GOARCH: "386"
        GOOS: linux
        EXTRA_FILES: "LICENSE"
  release-linux-amd64:
    name: release linux/amd64
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: compile and release
      uses: spetr/go-release.action@v1.0.3
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        GOARCH: amd64
        GOOS: linux
        EXTRA_FILES: "LICENSE"
  release-linux-arm:
    name: release linux/386
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: compile and release
      uses: spetr/go-release.action@v1.0.3
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        GOARCH: "arm"
        GOOS: linux
        EXTRA_FILES: "LICENSE"
  release-linux-arm64:
    name: release linux/amd64
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: compile and release
      uses: ngs/go-release.action@v1.0.1
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        GOARCH: arm64
        GOOS: linux
        EXTRA_FILES: "LICENSE"
  release-darwin-amd64:
    name: release darwin/amd64
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: compile and release
      uses: spetr/go-release.action@v1.0.3
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        GOARCH: amd64
        GOOS: darwin
        EXTRA_FILES: "LICENSE"
  release-windows-386:
    name: release windows/386
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: compile and release
      uses: spetr/go-release.action@v1.0.3
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        GOARCH: "386"
        GOOS: windows
        EXTRA_FILES: "LICENSE"
  release-windows-amd64:
    name: release windows/amd64
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: compile and release
      uses: spetr/go-release.action@v1.0.3
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        GOARCH: amd64
        GOOS: windows
        EXTRA_FILES: "LICENSE"
```
