# Mermaid

## Mermaid-cli error

```
Generating single mermaid chart

Error: Failed to launch the browser process!
/home/michael/.cache/puppeteer/chrome-headless-shell/linux-131.0.6778.204/chrome-headless-shell-linux64/chrome-headless-
shell: error while loading shared libraries: libasound.so.2: cannot open shared object file: No such file or directory
```

```sh
sudo apt -y install libasound2t64 # provide libasound2
```
