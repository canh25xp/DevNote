---
id: p4
aliases:
  - perforce
tags:
  - cli
  - windows
  - linux
---

# Perforce command line `p4` setup guide

## Windows

### Installation

First, check if `p4` is already installed:

```ps1
Get-Command -Name p4
```

#### Use `P4V`

If you already have `P4V` installed, chances are you already have `p4` too.
Check the default install location `C:\Program Files\Perforce`

```ps1
ls 'C:\Program Files\Perforce\p4.exe'
```

You should see:

```
    Directory: C:\Program Files\Perforce

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---            5/9/2025 12:44 PM        9715088 p4.exe
```

Then all left todo is add the `C:\Program Files\Perforce` to `PATH` environment variable.

#### Install `p4` separately

1. Download the latest `p4.exe` from the Perforce website: https://www.perforce.com/downloads/helix-core-apps
2. Choose the appropriate version for your system (e.g., Windows 64‑bit).
3. Save `p4.exe` to a folder of your choice, e.g., `C:\Tools\p4`.
4. Add that folder to your `PATH`:
    - Open **System Properties** → **Advanced** → **Environment Variables**.
    - Under **System variables**, edit `Path` and add `C:\Tools\p4` (or the folder you chose).

5. Open a new Command Prompt and verify:

    ```cmd
    p4 -V
    ```

    You should see the version information.

### Setup

Configure Perforce client settings. You can set them globally (environment variables) or per workspace.

#### Using `p4 set` (recommended)

```cmd
p4 set P4PORT=perforce:1666
p4 set P4USER=your_username
p4 set P4CLIENT=your_workspace_name
```

- `P4PORT` – address of the Perforce server.
- `P4USER` – your Perforce user name.
- `P4CLIENT` – name of the client workspace (you will create it next).

#### Create a workspace

```cmd
p4 client -o > myclient.txt
```

Edit `myclient.txt` to set the `Root` (local directory) and `View` (mapping). Then submit:

```cmd
p4 client -i < myclient.txt
```

You can also run `p4 client` interactively and fill the prompts.

After the workspace is created, run:

```cmd
p4 sync
```

to fetch files from the depot.

### Some common commands

| Command                      | Description                                           |
| ---------------------------- | ----------------------------------------------------- |
| `p4 sync`                    | Bring your workspace up to date with the depot.       |
| `p4 edit <file>`             | Open a file for edit.                                 |
| `p4 add <file>`              | Add a new file to the depot.                          |
| `p4 delete <file>`           | Mark a file for deletion.                             |
| `p4 revert <file>`           | Discard changes in a opened file.                     |
| `p4 submit -d "description"` | Submit opened files as a changelist.                  |
| `p4 opened`                  | List files currently opened in your workspace.        |
| `p4 changes`                 | Show submitted changelists.                           |
| `p4 diff <file>`             | Show differences between workspace and depot version. |
| `p4 resolve`                 | Resolve conflicts after a `p4 sync`.                  |

## Linux

### Installation

# Check if `p4` is already installed

which p4

```bash
# Download the latest p4 binary (replace URL with the current version)
curl -O https://ftp.perforce.com/perforce/r21.2/bin.linux26x86_64/p4

# Make it executable
chmod +x p4

# Move it to a directory in your PATH
sudo mv p4 /usr/local/bin/

# Verify installation
p4 -V
```

### Add to PATH (if you placed it elsewhere)

```bash
export PATH=$PATH:/path/to/p4
```

Add the above line to your `~/.bashrc` or `~/.zshrc` and reload the shell.

### Setup

The setup steps are identical to Windows; use `p4 set` to configure `P4PORT`, `P4USER`, and `P4CLIENT`, then create a workspace with `p4 client` and sync with `p4 sync`.

## macOS

### Installation

# Check if `p4` is already installed

which p4

You can install the `p4` binary via Homebrew or manual download.

#### Homebrew (recommended)

```sh
brew install --cask perforce
```

This installs `p4` and adds it to your PATH.

#### Manual download

1. Download the latest `p4` binary for macOS from the Perforce website: https://www.perforce.com/downloads/helix-core-apps
2. Move it to `/usr/local/bin`:

    ```sh
    sudo mv p4 /usr/local/bin/
    sudo chmod +x /usr/local/bin/p4
    ```

3. Verify installation:

    ```sh
    p4 -V
    ```

### Add to PATH (if needed)

If you placed the binary elsewhere, add it to your shell profile:

```sh
export PATH=$PATH:/path/to/p4
```

Add the line to `~/.zshrc` or `~/.bash_profile` and reload.

### Setup

The setup steps are the same as Linux/Windows. Use `p4 set` to configure server, user, and client, then create a workspace and sync.

## Verification

After installation and configuration, run a simple command to ensure connectivity:

```sh
p4 info
```

You should see output with server address, user, client name, and root directory. If you get an error, double‑check your `P4PORT`, `P4USER`, and network connectivity.
