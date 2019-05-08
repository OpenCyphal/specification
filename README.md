# UAVCAN specification

[![Forum](https://img.shields.io/discourse/https/forum.uavcan.org/users.svg)](https://forum.uavcan.org)

The sources of the UAVCAN specification and other related documents are contained here.

When cloning this repository, don't forget to initialize the Git submodules:
`git submodule update --init --recursive`.

## Compiling

A GNU/Linux-based operating system is assumed.
The described instructions may be valid for other operating systems but this is not guaranteed.

In order to compile the document, install TexLive (Debian-based APT packages: `texlive-full lyx`)
and the following Python packages:

- `pygments` (for Debian-based systems, use APT package `python-pygments`)
- [`pydsdl`](https://github.com/UAVCAN/pydsdl)

When done, run `./compile.sh`.

## Editing

First, ensure that you can compile the document as described above.
Do not proceeed further until that requirement is satisfied.

Use Visual Studio Code with extensions `James-Yu.latex-workshop` and `ban.spellright` for editing.
More info in the [Zubax Knowledge Base](https://kb.zubax.com/x/IYEh).

If you're using Visual Studio Code, the following settings for `James-Yu.latex-workshop` may be useful
(paste them into your user config file):

```json
{
    "latex-workshop.view.pdf.hand": true,
    "latex-workshop.latex.recipes": [
        {
            "name": "pdflatex x3",
            "tools": [
                "pdflatex",
                "pdflatex",
                "pdflatex"
            ]
        }
    ],
    "latex-workshop.latex.tools": [
        {
            "name": "pdflatex",
            "command": "pdflatex",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "--halt-on-error",
                "--shell-escape",
                "%DOC%"
            ]
        },
        {
            "name": "bibtex",
            "command": "bibtex",
            "args": [
                "%DOCFILE%"
            ]
        }
    ]
}
```

Add the following user dictionary file to squelch bogus spelling errors from Spellright:
<https://gist.github.com/pavel-kirienko/bd3ecf47fbdb164baeb408af31100f7d>.
**Do not edit the document without the spell checker.**

## License

All data contained herein is distributed under the terms of the
[Creative Commons Attribution 4.0 International license (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/),
unless explicitly stated otherwise.
