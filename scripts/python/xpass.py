#!/usr/bin/env python3
"""
XPASS – Python port of the PowerShell password generator.

Features
--------
* Random mode – configurable length and character sets.
* Memorable mode – three‑word passphrase with optional digits/symbols.
* Wordlist support (expects a plain‑text file named ``wordlist.txt`` in the same folder).
* Rate limiting – after 10 generations a 15‑second cooldown is enforced.
* Clipboard copy (requires the optional ``pyperclip`` package).
* Fancy ASCII‑art banner (cyan) matching the original PowerShell UI.
"""

import argparse
import os
import random
import sys
import time
from pathlib import Path

LOWER_POOL = list("abcdefghijklmnopqrstuvwxyz")
UPPER_POOL = list("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
DIGIT_POOL = list("0123456789")
SYMBOL_POOL = list(
    "!@#$%^&*()-_+={}[]:;<>?/|~"
)  

BANNER = r"""
 __   ________  ___   _____ _____ 
 \ \ / /| ___ \/ _ \ / .___/ .___|
  \ V / | |_/ / /_\ \\ .--.\ .--. 
  /   \ |  __/|  _  | \--. \\--. \ 
 / /^\ \| |   | | | |/\__/ /\__/ /
 \/   \/\_|   \_| |_/\____/\____/ .py [v0.1]
               by ghOSINT [github.com/GH0SINT]
"""
def print_banner() -> None:
    """Print the banner in cyan."""
    cyan = "\033[96m"
    reset = "\033[0m"
    print(cyan + BANNER + reset)

def load_wordlist(path: Path) -> list[str]:
    """Read a wordlist file and return a list of words."""
    if not path.is_file():
        sys.exit(f"ERROR: Wordlist file not found at {path}")
    words = [
        line.strip().split()[-1]
        for line in path.read_text(encoding="utf-8").splitlines()
        if line.strip()
    ]
    if len(words) < 3:
        sys.exit("ERROR: Wordlist must contain at least three words.")
    return words

def generate_random_password(
    length: int,
    include_lower: bool,
    include_upper: bool,
    include_digits: bool,
    include_symbols: bool,
) -> str:
    """Create a random password respecting the selected character sets."""
    pools = []
    guaranteed = []

    if include_lower:
        pools.append(LOWER_POOL)
        guaranteed.append(random.choice(LOWER_POOL))
    if include_upper:
        pools.append(UPPER_POOL)
        guaranteed.append(random.choice(UPPER_POOL))
    if include_digits:
        pools.append(DIGIT_POOL)
        guaranteed.append(random.choice(DIGIT_POOL))
    if include_symbols:
        pools.append(SYMBOL_POOL)
        guaranteed.append(random.choice(SYMBOL_POOL))

    if not pools:
        raise ValueError("At least one character set must be enabled.")

    min_required = len(guaranteed)
    if length < min_required:
        raise ValueError(
            f"Requested length ({length}) is shorter than the minimum required ({min_required}) "
            "to satisfy all enabled character sets."
        )

    master_pool = [ch for pool in pools for ch in pool]

    remaining_len = length - len(guaranteed)
    random_part = [random.choice(master_pool) for _ in range(remaining_len)]

    password_chars = guaranteed + random_part
    random.shuffle(password_chars)
    return "".join(password_chars)

def generate_memorable_password(wordlist: list[str]) -> str:
    """Build a memorable password from three words with added digits/symbols."""
    WORD_COUNT = 3
    words = random.sample(wordlist, WORD_COUNT)

    upper_idx = random.randrange(WORD_COUNT)
    for i, w in enumerate(words):
        if i == upper_idx:
            words[i] = w[:1].upper() + w[1:].lower()
        else:
            words[i] = w.lower()

    num_digits = random.randint(1, 3)
    for _ in range(num_digits):
        idx = random.randrange(WORD_COUNT)
        digit = random.choice(DIGIT_POOL)
        pos = random.choice(["start", "end"])
        words[idx] = (digit + words[idx]) if pos == "start" else (words[idx] + digit)

    num_symbols = random.randint(1, 3)
    for _ in range(num_symbols):
        idx = random.randrange(WORD_COUNT)
        symbol = random.choice(SYMBOL_POOL)
        pos = random.choice(["start", "end"])
        words[idx] = (symbol + words[idx]) if pos == "start" else (words[idx] + symbol)

    return "".join(words)

def remind_memorable_requirements() -> None:
    """Print the reminder shown in the PowerShell UI."""
    cyan = "\033[96m"
    reset = "\033[0m"
    print(f"{cyan}Reminder: Memorable passwords must contain at least:{reset}")
    print(f"{cyan} - 1 uppercase letter{reset}")
    print(f"{cyan} - 1 lowercase letter{reset}")
    print(f"{cyan} - 1 digit{reset}")
    print(f"{cyan} - 1 special character{reset}\n")

def main() -> None:
    parser = argparse.ArgumentParser(
        description="XPASS – Random / Memorable password generator (clipboard removed)",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument(
        "-l",
        "--length",
        type=int,
        default=16,
        help="Desired password length (random mode only)",
    )
    parser.add_argument(
        "--no-lower",
        dest="include_lower",
        action="store_false",
        help="Exclude lowercase letters",
    )
    parser.add_argument(
        "--no-upper",
        dest="include_upper",
        action="store_false",
        help="Exclude uppercase letters",
    )
    parser.add_argument(
        "--no-digits",
        dest="include_digits",
        action="store_false",
        help="Exclude digits",
    )
    parser.add_argument(
        "--no-symbols",
        dest="include_symbols",
        action="store_false",
        help="Exclude symbols",
    )
    parser.add_argument(
        "-w",
        "--wordlist",
        type=Path,
        default=Path("wordlist.txt"),
        help="Path to a plain‑text wordlist (required for memorable mode)",
    )
    args = parser.parse_args()

    generation_counter = 0

    while True:
        print("\n")
        print_banner()
        print("\033[95m=== XPASS – Password Generator ===\033[0m")
        print("Choose password type:")
        print("  1) Random")
        print("  2) Memorable")
        choice = input("Enter 1 or 2 (default 1): ").strip() or "1"

        memorable_mode = choice == "2"

        if memorable_mode:
            remind_memorable_requirements()
            if not args.wordlist.is_file():
                print(f"\033[91mERROR: Wordlist file not found at {args.wordlist}\033[0m")
                continue
            wordlist = load_wordlist(args.wordlist)

        while True:
            generation_counter += 1

            if memorable_mode:
                pwd = generate_memorable_password(wordlist)
            else:
                try:
                    pwd = generate_random_password(
                        length=args.length,
                        include_lower=args.include_lower,
                        include_upper=args.include_upper,
                        include_digits=args.include_digits,
                        include_symbols=args.include_symbols,
                    )
                except ValueError as e:
                    print(f"\033[91mError: {e}\033[0m")
                    break  

            print("\n\033[93mGenerated Password:\033[0m", pwd)

            if generation_counter >= 10:
                print(
                    "\n\033[96mYou are generating passwords quickly. Please wait 15 seconds before continuing.\033[0m"
                )
                time.sleep(15)
                generation_counter = 0
                break  

            again = input("\nGenerate another password? [Y/n] ").strip().lower()
            if again not in ("", "y", "yes"):
                break  

        cont = input("\nReturn to main menu? [Y/n] ").strip().lower()
        if cont not in ("", "y", "yes"):
            print("\nGood‑bye!")
            break

if __name__ == "__main__":
    main()
