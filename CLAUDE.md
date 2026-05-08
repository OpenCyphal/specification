# Cyphal specification — notes for AI agents

Read `README.md` first; it contains the authoritative editing rules, label conventions,
source-formatting style, and build instructions. This file captures the project-specific
context that is easy to miss on a cold read.

## Key external sources of truth

These live outside this repository but are the authoritative references for anything
the spec says about the session layer:

- <https://github.com/OpenCyphal-Garage/cy> -- the C reference implementation, design notes, formal models and proofs.
- <https://github.com/OpenCyphal/libcanard> -- the Cyphal/CAN transport layer C reference implementation.
- <https://github.com/OpenCyphal/libudpard> -- the Cyphal/UDP transport layer C reference implementation.

When working on the specification, ensure that these repositories are cloned in the outer directory (`../`);
if not, clone them and check out the main branch.

Numerical constants (moduli, tag widths, header sizes, etc.) and test vectors in the spec are generated from these
sources and must reproduce bit-for-bit.
When adding or revising a test vector, regenerate it from the reference C implementation.

## Repository layout

```
./
├── README.md              # authoritative editing guide
├── CLAUDE.md              # this file
├── compile.sh             # builds the PDF
├── clean.sh               # removes build artifacts
└── specification/
    ├── Cyphal_Specification.tex   # root document; \input's every chapter
    ├── cyphaldoc.cls              # custom document class; defines remark, CyphalSimpleTable, etc.
    ├── introduction/introduction.tex
    ├── session/                   # main focus of v1.1; composed of several chapter-local files
    ├── transport/
    └── appendices/                # proofs, TLA+, formal models, references, ...
```

A chapter directory contains one main `.tex` file that `\input`s its subordinate files.

## Building

```sh
./compile.sh
```

Ensure it builds cleanly and the PDF looks sensible before declaring the work done.

## Style rules that are easy to forget

Most of the house style lives in `README.md`. A few points warrant extra emphasis:

- **Be brief.** v1.0 was too verbose. The spec must be tight: push rationale into `remark` boxes,
  avoid restating transport-layer definitions, and cross-reference rather than repeat.
- **No API description.** Describe observable wire behavior and state transitions only.
  Words like "future" are allowed as conceptual handles when describing asynchronous
  state transitions, but they are not API promises.
- **Lowercase shall / should / may.** The document uses lowercase RFC 2119 keywords in prose.
- **ASCII only inside `minted` bodies.** The `minted` listings use `inputenc` under `pdflatex`,
  which rejects Unicode characters like `∪`, `≤`, `→`.
  Use ASCII substitutes (`union`, `<=`, `->`) or TeX math in surrounding prose instead.

Heavy rationale, the CRDT proof, the TLA$^+$ listing, the rapidhash reference
implementation, the eviction solver, and the gossip analytical models all live under
`specification/appendices/` and are referenced from the main body.
