# GH0SINT / scripts – Master README

![License](https://img.shields.io/github/license/GH0SINT/scripts?color=blue)
![Stars](https://img.shields.io/github/stars/GH0SINT/scripts?style=social)
![Last commit](https://img.shields.io/github/last-commit/GH0SINT/scripts)
![Languages](https://img.shields.io/github/languages/count/GH0SINT/scripts)

> A curated toolbox of Bash, Batch, PowerShell, and Python scripts for everyday sysadmin, dev‑ops, and hobbyist tasks.  
> All scripts are zero‑dependency (except where a standard interpreter is required) and preserve their own commit history.  
> Some scripts are created some are credited to other authors.

## 📚 Table of Contents 📚

1️⃣ [Bash](#1️⃣-bash)  
2️⃣ [Batch](#2️⃣-batch)  
3️⃣ [PowerShell](#3️⃣-powershell)  
4️⃣ [Python](#4️⃣-python)  
5️⃣ [License](#5️⃣-license)  
6️⃣ [Contributing](#6️⃣-contributing)  

## 🚀 Getting started  🚀 

```bash
# Clone the repo
git clone https://github.com/GH0SINT/scripts.git
cd scripts

# List the available toolkits
ls -d */   # shows: bash/  batch/  powershell/  python/
```
Pick the language you need and follow the linked README for usage details.

1️⃣ Bash (bash/README.md)  
Portable Bash utilities for Linux/macOS/WSL.  
See the full README in scripts/bash/README.md for a list of scripts, usage examples, prerequisites, and contribution guidelines.

2️⃣ Batch (batch/README.md)  
Classic Windows .bat helpers (zero‑dependency).  
See the full README in scripts/batch/README.md for script descriptions, usage, and contribution notes.

3️⃣ PowerShell (powershell/README.md)  
Reusable PowerShell functions, modules, and one‑offs.  
See the full README in scripts/powershell/README.md for a catalog of scripts, examples, and how to contribute.

4️⃣ Python (python/README.md)  
Small Python 3 scripts with minimal third‑party dependencies.
See the full README in scripts/python/README.md for script details, installation steps, and contribution advice.

5️⃣ License  
All code in this repository is released under the MIT‑style license located in the root LICENSE file.  
Each individual script should retain its copyright header.  

6️⃣ Contributing
Fork the repository and create a feature branch.  
Follow the language‑specific style guidelines found in each sub‑folder’s README.  
Keep scripts idempotent and self‑contained.  
When you add a new script, update the appropriate sub‑folder README (and optionally this master README if you add a new language folder).  
Open a Pull Request with a clear description of the changes.  
Tip: If you introduce a completely new language/toolset, copy the structure of this master README (table of contents → sub‑folder sections) so the repository stays easy to navigate.

## Supported platforms  

| Language   | OS / Shell                              |
|------------|------------------------------------------|
| Bash       | Linux, macOS, WSL                        |
| Batch      | Windows (cmd)                            |
| PowerShell | Windows, macOS, Linux (PowerShell 7)      |
| Python     | Any OS with Python 3.8+                  |

---  

💬 **Questions?** Open an issue, or drop me a line at `gh0sint@protonmail.com`.  
🔧 **Found a bug?** Please file a GitHub Issue with steps to reproduce.  
🗒️ **Changelog** – see `CHANGELOG.md` for a history of releases and major updates.   

