## zvarpwd — tiny password generator in Zig 🔐⚡

A super lightweight CLI tool to print a random password to stdout. Built to practice Zig — turns out it’s so handy that it’s become a daily driver.

### Highlights ✨
- **Small and fast**: trivial build, instant runtime.
- **Reasonable entropy mix**: digits, uppercase, lowercase; two dots for readability.
- **No config needed**: just run and get a password.

### How it works (from `src/main.zig`) 🧠
- Seeds Zig’s default PRNG with 64-bit entropy from the OS (`getrandom`).
- Chooses a total length in the range **18–22** characters.
- Picks two positions for `.`: one in **[2..8]**, one in **[10..16]**.
- First character is always a lowercase letter.
- Fills the rest with a mix of digits (0–9), uppercase (A–Z), and lowercase (a–z), inserting dots at the chosen positions.
- Prints the result followed by a newline.

Note: Zig’s default PRNG is not a cryptographically secure generator. This tool is fine for everyday use, but for high-security secrets or compliance-sensitive contexts prefer a CSPRNG-based generator.

### Build 🛠️
```bash
zig build
```

Optionally choose an optimization mode via `-Doptimize=ReleaseFast`.

### Run ▶️
After building, the binary is at `zig-out/bin/zvarpwd`:
```bash
./zig-out/bin/zvarpwd
```
or via the build runner:
```bash
zig build run
```

### Example output 📦
These are real samples produced by the tool:
```
dRN5nu.EgK7bbm.Udw
t1X35L.8N03nX4r1.0h
x7v.Y3xZw2BH2S.30iwLL
```

### Performance 📉
It’s extremely lightweight — on a typical Linux machine it completes in a fraction of a millisecond:

- ⏱️ Task time: around **0.16 ms** of CPU time to generate and print a password.
- 🔄 Context switches/migrations: **0** — it runs straight through on the CPU.
- 📄 Page faults: roughly **~20 minor faults** — negligible and expected during first touch.
- 🧮 Cycles & instructions: about **~0.5M cycles** and **~0.44M instructions** → **~0.8–0.9 IPC**; a tiny instruction footprint.
- ↪️ Branches: roughly **~90k branches** with **~12% misses** — typical for a small PRNG/string loop; impact is trivial at this scale.
- 👟 User/sys time: **~0.00045 s user**, **~0.00000 s sys** — near-zero kernel overhead.

In short: the whole run fits within a few hundred microseconds; most of the cost is just printing to stdout. 🚀

### License 📝
GPL-3.0 — see `LICENSE`.
