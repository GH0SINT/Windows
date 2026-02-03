# Bash Scripts – `bash/README.md`

> **Quick summary** – A small collection of portable Bash utilities for Linux, macOS, and WSL.  
> All scripts are written for **Bash 4+**, have **zero external dependencies**, and include built‑in help output.

---

## 📚 Table of Contents 📚  

1. [Installation & prerequisites](#installation--prerequisites)  
2. [Usage patterns](#usage-patterns)  
3. [Adding a new script](#adding-a-new-script)  
4. [Contributing](#contributing)  
5. [License](#license)  

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
```

## Usage patterns
1️⃣ Direct execution  

# Make the script executable (once)
```bash
chmod +x <scriptname>.sh
```
# Run it
```bash
./<scriptname>.sh /path/to/project
```

2️⃣ Sourcing as a library
Some scripts expose functions that you can source into your own Bash programs:  
```bash
# In your own script  
source "$(dirname "$0")/<scriptname>.sh"  

# Now you can call the function directly  
show_largest "/var/log" 10   # show top 10 biggest entries
```
> Convention: Functions are prefixed with bu_ (Bash Utility) to avoid name clashes, e.g. bu_cleanup_tmp.

3️⃣ Using the built‑in help
```bash
./<scriptname>.sh -h
# or
source <scriptname>.sh
bu_<scriptname> -h
```
Typical help output looks like:  

Usage: ping_sweep.sh <CIDR>
  Example: ping_sweep.sh 192.168.1.0/24
  Options:
    -h, --help   Show this help message and exit

## Adding a new script
1. Create the file in scripts/bash/ and make it executable:  
```bash
touch my_new_tool.sh
chmod +x my_new_tool.sh
```
2. Add a header comment that follows the template below (helps --help generation and future readers):  
```bash
#!/usr/bin/env bash
#
# my_new_tool.sh – one‑line description
#
# Usage:   my_new_tool.sh [options] <arg>
# Options:
#   -h, --help   Show this help message and exit
#   -v, --verbose   Enable verbose output
#
# Author:  Your Name <you@example.com>
# License: MIT (see repository LICENSE)
```

3. Implement a print_help function and call it when $1 is -h/--help.  
4. Test locally (see the testing section below).  
5. Commit with a clear message, e.g. Add my_new_tool.sh – backup utility for MySQL dumps.  

## Contributing  
1. Fork the repository and create a feature branch (git checkout -b feature/my‑new‑tool).  
2. Follow the coding conventions outlined above (header comment, -h/--help, bu_ prefix for functions).  
3. Run shellcheck locally; the CI will reject the PR if linting fails.  
4. Write a short README entry (or update this file) describing the new script.  
5. Open a Pull Request with a clear description of what the script does and why it belongs in the collection.  

> Tip: If you’re adding a script that depends on a non‑standard utility (e.g., jq), please note that requirement in the script’s header and in the “Installation & prerequisites” table.  

## License  
All scripts in this folder are released under the MIT‑style license that applies to the whole repository (see the top‑level LICENSE file).  
If you incorporate third‑party code, keep the original attribution comment at the top of the script.
