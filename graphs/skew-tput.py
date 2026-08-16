#!/usr/bin/env python3
"""Regenerate graphs/skew-tput.pdf.

ACM production rejects bit-mapped Type 3 fonts, which are what matplotlib's PDF
backend emits by default.  We therefore render through the pgf/pdflatex backend
so the figure text is typeset with the same embedded Type 1 Linux Libertine
faces as the paper body, and stays searchable.

Run from the repository root:  .venv/bin/python graphs/skew-tput.py
"""

import matplotlib

matplotlib.use("pgf")
matplotlib.rcParams.update(
    {
        "pgf.texsystem": "pdflatex",
        "pgf.rcfonts": False,
        "pgf.preamble": "\\usepackage{libertine}",
        "text.usetex": True,
        "font.family": "serif",
        "font.size": 7,
        "axes.labelsize": 7,
        "xtick.labelsize": 7,
        "ytick.labelsize": 7,
        "legend.fontsize": 7,
    }
)

import matplotlib.pyplot as plt
import numpy as np

SKEW = ["0.0", "0.5", "0.99", "1.24"]
BIG = [48057, 52097, 122460, 350365]
FULL = [37306, 41238, 101115, 307060]

x = np.arange(len(SKEW))
width = 0.38

fig, ax = plt.subplots(figsize=(2.5, 1.8))
bars = [
    ax.bar(x - width / 2, BIG, width, label="BigBFT"),
    ax.bar(x + width / 2, FULL, width, label="Full replication"),
]
for b in bars:
    ax.bar_label(b, fmt=lambda v: f"{v / 1000:.0f}k", padding=1, fontsize=6)

ax.set_xlabel("Skewness")
ax.set_ylabel("Throughput (ops/s)")
ax.set_xticks(x, SKEW)
ax.set_yticks(np.arange(0, 400001, 100000), ["0", "100k", "200k", "300k", "400k"])
ax.set_ylim(0, 420000)
ax.grid(axis="y", linewidth=0.4, alpha=0.5)
ax.set_axisbelow(True)
ax.legend(loc="upper left", frameon=True, framealpha=1.0, borderpad=0.3)

fig.tight_layout(pad=0.2)
fig.savefig("graphs/skew-tput.pdf")
