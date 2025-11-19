---
id: password
aliases: []
tags:
  - git
  - pass
  - gpg
---

# Create your own self-hosted password manager with `git` and `pass`

> [!WARNING]
> AI generated, need review

Features:

- A secure password store (encrypted with GPG)
- Version-controlled secrets synced via Git
- A simple workflow to import on any new machine (I said simple, not easy)

---

## First setup

### Installation

```bash
sudo apt install pass gpg git
```

### Create or use a GPG key

If you already have a GPG key, skip to Step 3.

Create a new key:

```bash
gpg --full-generate-key
```

**Choose:**

- RSA and RSA
- 4096 bits
- No expiry (or 1 year, depends on preference)
- Real name + email
- Set a strong passphrase

Check created key:

```bash
# --list-secret-keys
gpg -K
```

Example output:

```
sec   rsa4096/ABCDEF1234567890
      uid [ultimate] Van Canh Ngo <vancanh.ng@samsung.com>
```

Your key ID here is `ABCDEF1234567890`.

---

# **Step 3. Initialize `pass`**

Use your email or key ID:

```bash
pass init vancanh.ng@samsung.com
```

This tells `pass`:

> “Encrypt all passwords using this GPG key.”

It creates the directory:

```
~/.password-store
```

---

# **Step 4. Start storing secrets**

## Add a new password:

```bash
pass insert api/openai
```

It will prompt you securely (no echo).

## Add a password from a command:

```bash
echo -n "my-super-secret" | pass insert -f api/openai
```

## Read it:

```bash
pass api/openai
```

## List all secrets:

```bash
pass
```

---

# 🚀 **Part 2 — Sync Your Password Store with Git**

The recommended and most secure way to sync between machines is:

👉 **Store your password store in a private git repo**
👉 **Push only encrypted data**
👉 **Import your GPG private key on each machine**

## Step 5. Initialize Git inside pass

```bash
cd ~/.password-store
git init
git add .
git commit -m "Initial pass store"
git remote add origin git@github.com:yourname/pass-store.git
git push -u origin main
```

### ✔ Best practice

- Use **a private GitHub repo**, GitLab, or a self-hosted repo.
- The contents are **fully encrypted**, so pushing is safe.

---

# 🚀 **Part 3 — Setting Up `pass` on a New Machine**

Now imagine you’re setting up Laptop #2, a new workstation, etc.

## Step 6. Clone your encrypted password store

```bash
git clone git@github.com:yourname/pass-store.git ~/.password-store
```

At this point you have the encrypted secrets, but you **cannot decrypt them yet**.

---

# **Step 7. Install `pass` and GPG on the new machine**

```bash
sudo apt install pass gpg
```

---

# **Step 8. Import your GPG private key**

On Machine #1, export your **private key** safely:

```bash
gpg --export-secret-keys --armor vancanh.ng@samsung.com > privatekey.asc
```

**Best practice:**

- Put `privatekey.asc` onto a USB drive
- Or transfer via SSH
- **Do NOT** store this file in git, cloud, or email

On Machine #2, import it:

```bash
gpg --import privatekey.asc
```

Then trust it:

```bash
gpg --edit-key vancanh.ng@samsung.com trust
```

Choose:
**5 = ultimate trust**, then save.

---

# **Step 9. Reinitialize pass on Machine #2**

Now point pass to your imported key:

```bash
pass init vancanh.ng@samsung.com
```

Now `pass` can decrypt your secrets.

Try:

```bash
pass api/openai
```

It should work.

---

# 🚀 **Part 4 — Day-to-Day Workflow**

## Add a new secret:

```bash
pass insert wifi/home
```

## Edit an existing secret:

```bash
pass edit api/openai
```

## Sync:

```bash
cd ~/.password-store
git add .
git commit -m "Added wifi password"
git push
```

## On other machines:

```bash
cd ~/.password-store
git pull
```

All secrets stay encrypted during transit.

---

# 🚨 **Security Best Practices (Important)**

### 👉 1. Your GPG **private key** must be backed up securely

Use:

- USB key
- Offline storage
- YubiKey (optional, strongest)

### 👉 2. Never put private keys into Git

Only encrypted secrets go in Git.

### 👉 3. Use a strong GPG passphrase

Without this, if someone steals your `privatekey.asc`, they can decrypt everything.

### 👉 4. Prefer `pass insert` over storing plaintext on disk

Avoid:

```
echo "password" > pass.txt
```

### 👉 5. Keep your pass repo private

Even though encrypted, don't expose metadata.

---

# 🎁 Want the best experience? (Recommended)

I can generate for you:

- A `.bashrc` function:
  `passenv OPENAI_API_KEY api/openai`
- A Neovim Lua helper to auto-load secrets into plugins
- A PowerShell wrapper for Windows to load passwords via `pass`
- A script to export & restore your GPG setup on new machines
