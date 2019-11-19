# UAVCAN specification

[![Forum](https://img.shields.io/discourse/https/forum.uavcan.org/users.svg)](https://forum.uavcan.org)

The sources of the UAVCAN specification and other related documents are contained here.

When cloning this repository, don't forget to initialize the Git submodules:
`git submodule update --init --recursive`.

## Style guide

Follow the Zubax LaTeX guide: <https://kb.zubax.com/x/IYEh>.
**Do not edit the document without the spell checker.**

Critical definitions (behaviors, constraints, assumptions, etc.) shall be written in the main body of the document. Optional content (clarifications, examples, elaborations) is placed either into footnotes or into blue remark boxes
which can be defined using `\begin{remark}...\end{remark}`.

Never address the reader directly.
Do not hesitate to use passive voice.
For example, instead of "you can find the data type X here", say "the data type X can be found here".

In order to refer to a DSDL definition, use the macro `\DSDLReference{}`.
Refer to its existing usages for an example.

## Tools

### Compiling

A GNU/Linux-based operating system is assumed.
The described instructions may be valid for other operating systems but this is not guaranteed.

In order to compile the document, install TexLive (Debian-based APT packages: `texlive-full lyx`)
and the Python packages listed in `requirements.txt`.

When done, run `./compile.sh`.

### IDE setup

First, ensure that you can compile the document as described above.
Do not proceed further until that requirement is satisfied.

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

Use the dictionary file `.vscode/spellright.dict` to squelch bogus spelling errors from Spellright.
