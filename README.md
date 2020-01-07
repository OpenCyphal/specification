# UAVCAN specification

[![Forum](https://img.shields.io/discourse/https/forum.uavcan.org/users.svg)](https://forum.uavcan.org)

The sources of the UAVCAN specification and other related documents are contained here.

When cloning this repository, don't forget to initialize the Git submodules:
`git submodule update --init --recursive`.

## Editing guide

### Style

Follow the Zubax LaTeX guide: <https://kb.zubax.com/x/IYEh>.
**Do not edit the document without the spell checker.**

Write in American English <sub>*(don't look at me, I'm trying my best)*</sub>.

Critical definitions (behaviors, constraints, assumptions, etc.) shall be written in the main body of the document.
Optional content (clarifications, examples, elaborations) is placed either into footnotes or into blue remark boxes
which can be defined using `\begin{remark}...\end{remark}`.

Never address the reader directly.
Do not hesitate to use passive voice.
For example, instead of "you can find the data type X here", say "the data type X can be found here".

Follow [RFC2119](https://tools.ietf.org/rfc/rfc2119.txt).

### Rigging

In order to refer to a DSDL definition, use macro `\DSDLReference{}`.
To include a DSDL definition or a namespace index, use macro `\DSDL{}`.
Refer to the existing usages for an example.

### Structure and cross-referencing

Each chapter is located in a dedicated directory, whose name is a single lowercase word.
The main file of the chapter is located in a file under the same name as the directory.
For example: `chapter/chapter.tex` (where "chapter" is the chapter name placeholder).

When defining a new label, you must use the prefix following the pattern `kind:chapter`, where:

- "kind" is the kind of the labeled item, such as `fig`, `table`, or `sec`;
- "chapter" is the name of the directory where the chapter is contained.

The label that contains only the prefix points to the chapter itself using the kind `sec`.
For example, if the chapter is named "Transport layer", its label would be `sec:transport`.

Items contained inside the chapter (sections, figures, tables) are named using free form
appended to the prefix.
For example, one could refer to a figure contained inside the chapter "Chapter" as `fig:chapter_my_figure`.

The above rules are crucial to follow to keep cross-references usable.
Without strict conventions in place, they quickly become unmanageable.

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
