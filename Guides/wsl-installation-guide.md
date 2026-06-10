---
id: wsl-installation-guide
aliases: []
tags: []
---

# WSL Installation Guide

This guide walks you through installing **WSL (Windows Subsystem for Linux)** manually using packages hosted on a local server.

## 📦 Required Files

Download the following files:

- WSL package:
  [wsl.2.6.3.0.x64.msi](http://107.98.150.183:6969/Archive/WSL/wsl.2.6.3.0.x64.msi)

- Debian distro tar:
  [debian.unstable.tar](http://107.98.150.183:6969/Archive/WSL/debian.unstable.tar)

---

## ⚙️ Step 1: Enable Required Windows Features

Open **PowerShell as Administrator** and run:

```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

Then **restart your computer**.

---

## 🧩 Step 2: Install WSL

Run the downloaded installer:

```
wsl.2.6.3.0.x64.msi
```

This installs the core **WSL runtime**.

---

## 🐧 Step 3: Install Distro

```powershell
curl -LO http://107.98.150.183:6969/Archive/WSL/debian.unstable.tar
wsl --import Debian C:\WSL\Debian .\debian.unstable-080420260230.tar --version 2
```

---

## ✅ Step 4: Verify Installation

Run:

```powershell
wsl --status
wsl --list --verbose
```

---

## 🚀 Step 5: Launch Debian

```powershell
wsl -d Debian
```
