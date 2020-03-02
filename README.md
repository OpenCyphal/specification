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

Do not use title case. Headings and captions are to be written in regular sentence case.
Generally, capitalized words can only be used in the beginning of a sentence and in proper names.

Do not put a full stop after a caption unless it contains any other punctuation or is more than one sentence long.

Always insert a non-breakable space before reference: `refer to section~\ref{sec:chapter_section}`.

When referring to a category of identifiers, put a hyphen before "ID"; for example: "node-ID" is correct, "node ID" is not.

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

### Source formatting

- One level of nesting shall be indented with 4 spaces. Tabs shall not be used anywhere in the source.
- There shall be no more than 120 characters per line.
- There shall be exactly one blank line at the end of the file.
- There shall be no more than one consecutive blank line.
- There shall be at most one chapter per source file.
- There shall be one blank line above and below a section header,
unless the section header is at the top of the source file.
- Multi-line content enclosed in curly braces should be indented.
- If a list item spills on the next line, the spilled text should be indented on the same level with the first line.

```tex
\begin{itemize}
    \item This list item is sufficiently long to exceed the limit of 120 characters per line,
          so it has to spill onto the next line.
          The spilled part is indented correctly.

    \item Another item.
\end{itemize}

% The next line contains a comment to remove the whitespace in the beginning of the footnote.
Regulated non-standard definitions\footnote{%
    I.e., public definitions contributed by vendors and other users
    of the specification, as explained in section~\ref{sec:basic_data_type_regulation}.
} are not included in this list.
```

## Tools

### Compiling

A GNU/Linux-based operating system is assumed.
The described instructions may be valid for other operating systems but this is not guaranteed.

In order to compile the document, install TeX Live
(Ubuntu packages: [`texlive-full`](https://packages.ubuntu.com/xenial/texlive-full) and `lyx`),
and make sure that the version of pdfLaTeX is `3.14159265-2.6-1.40.16`.
Any other version may miscompile the document with subtle typographical defects.
Install the Python packages listed in `requirements.txt`.

When done, run `./compile.sh`.

#### Using texer

You can use our Docker container to build the specification if you don't want to setup your own build environment.

1. pull [texer container](https://hub.docker.com/repository/docker/uavcan/texer)
2. `docker run --rm -it -v ${PWD}:/repo:delegated uavcan/texer:ubuntu-16.04`
3. `pip3 install pydsdl`
4. `./compile.sh`

### IDE setup

First, ensure that you can compile the document as described above.
Do not proceed further until that requirement is satisfied.

Use Visual Studio Code with extensions `James-Yu.latex-workshop` and `ban.spellright` for editing.
More info in the [Zubax Knowledge Base](https://kb.zubax.com/x/IYEh).

If you're using Visual Studio Code there are local settings for `latex-workshop` and you can use
the `.vscode/spellright.dict` to squelch bogus spelling errors from Spellright.

#### L33t IDE Setup

If you want to use our [texer container](https://hub.docker.com/repository/docker/uavcan/texer) with vscode then install the ["ms-vscode-remote.vscode-remote-extensionpack"](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) and Docker. When you open vscode in this repostory it should prompt you to "open this folder in container?". Otherwise `F1` or `CMD+SHIFT+P` and select `Remote-Containers: Reopen Locally`. Once within the container you can simply `F1` or `CMD+SHIFT+P` and `LaTeX Workshop: Build LaTeX project` to build the specification PDF.
