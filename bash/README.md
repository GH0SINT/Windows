# Bash Scripts – `bash/README.md`

> **Quick summary** – A small collection of portable Bash utilities for Linux, macOS, and WSL.  
> All scripts are written for **Bash 4+**, have **zero external dependencies**, and include built‑in help output.

---

## 📚 Table of Contents 📚  

1. [Installation & prerequisites](#installation--prerequisites)  
2. [Usage patterns](#usage-patterns)  
3. [Adding a new script](#adding-a-new-script)  
4. [Testing & linting](#testing--linting)  
5. [Contributing](#contributing)  
6. [License](#license)  

---

## 📜 Installation & prerequisites 📜

| Requirement | Details |
|-------------|---------|
| **Bash**    | Version 4.0 or newer (standard on most modern Linux/macOS distributions and on WSL). |
| **Core utilities** | `awk`, `sed`, `grep`, `cut`, `find`, `xargs`, `tar`, `gzip` – all ship with the base OS. |
| **Optional** | `shellcheck` (for linting) – install with `sudo apt-get install shellcheck` (Debian/Ubuntu) or `brew install shellcheck` (macOS). |

> **Tip:** The scripts are deliberately dependency‑free, so you can copy any of them to a new machine and they will work out‑of‑the‑box.

### Quick install (optional)

If you want the Bash folder on your `$PATH`:

```bash
# From the repository root
git clone https://github.com/GH0SINT/scripts.git
cd scripts/bash

# Add the folder to PATH for the current shell session
export PATH="$PWD:$PATH"

# Persist the change (add to ~/.bashrc or ~/.zshrc)
echo 'export PATH="'"$PWD"':$PATH"' >> ~/.bashrc
source ~/.bashrc
