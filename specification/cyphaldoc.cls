%
% Copyright (c) 2018-2019  OpenCyphal Development Team  <maintainers@opencyphal.org>
%
% Author: Pavel Kirienko <pavel@opencyphal.org>
%

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{cyphaldoc}[2018/06/29 Cyphal document class]

\LoadClass[a4paper,onecolumn,openany]{book}

\author{OpenCyphal Development Team}

\RequirePackage[pagestyles]{titlesec}
\RequirePackage{titletoc}
\RequirePackage[table,xcdraw]{xcolor}
\RequirePackage{gensymb}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{enumitem}
\RequirePackage{multicol}
\RequirePackage{etoolbox}
\RequirePackage{amstext}
\RequirePackage[detect-all]{siunitx}
\RequirePackage[font={bf}]{caption}
\RequirePackage{threeparttablex}
\RequirePackage{tabu}
\RequirePackage{makecell}
\RequirePackage{longtable}
\RequirePackage{ifthen}
\RequirePackage{calc}
\RequirePackage{titling}
\RequirePackage[yyyymmdd]{datetime}
\RequirePackage{lastpage}
\RequirePackage{minted}
\RequirePackage{chngcntr}
\RequirePackage{changepage}
\RequirePackage{csquotes}
\RequirePackage{xparse}
\usepackage[most]{tcolorbox}

%
% Minor definitions.
%
% OpenCyphal color palette: #1700b3 (logo color), #0003ee, #00dac6, #007e87, #b00036 #fc6d09
% Source: https://forum.opencyphal.org/t/cyphal-logo-palooza/1626/27?u=pavel.kirienko
\definecolor{colorlogo}{HTML}{1700B3}           % from the palette
\definecolor{colorhyperlink}{HTML}{0003EE}      % from the palette
\definecolor{colorremarkbg}{HTML}{E6F2FF}
\definecolor{colorremarkframe}{HTML}{6669FF}    % lightened 0003ee

\renewcommand{\dateseparator}{-}

\sisetup{range-phrase = \text{--}}

\newcommand\CyphalCopyright{\copyright{} 2015--\the\year{} \href{http://opencyphal.org}{\@author}}

% Deferring configuration of the PDF metadata until the point where the document title (and author) are known.
\preto\frontmatter{\hypersetup{
    pdftitle={\@title{} -- \@author},
    pdfauthor={\@author}
}}

% Source code listings highlighting
\usemintedstyle{vs}
\setminted{
    frame=leftline,
    linenos,
    numberblanklines=false,
    fontsize=\footnotesize,
    xleftmargin=\dimexpr\leftskip-2.15mm\relax,
    framesep=2mm,
    baselinestretch=1,
    autogobble
}
% The Pygments library is just too smart.
% We don't want it to highlight errors in our listings because our listings are obviously perfect.
% https://github.com/gpoore/minted/issues/69
\AtBeginEnvironment{minted}{\renewcommand{\fcolorbox}[4][]{#4}}
\preto\inputminted{\renewcommand{\fcolorbox}[4][]{#4}}

\renewcommand{\theFancyVerbLine}{\scriptsize \texttt \oldstylenums{\arabic{FancyVerbLine}}}

% List styling
\renewcommand{\labelitemi}{\textbullet}
\renewcommand{\labelitemii}{\textbullet}
\renewcommand{\labelitemiii}{\textbullet}
\renewcommand{\labelitemiv}{\textbullet}

\setlist[itemize,2]{leftmargin=2em}
\setlist[itemize,3]{leftmargin=3em}
\setlist[itemize,4]{leftmargin=4em}

\setlist[description]{leftmargin=\leftskip,labelindent=\dimexpr\leftskip+\parindent\relax}
\setlist[enumerate]{itemindent=0ex,leftmargin=\leftskip+1.4em,nosep}
\setlist[itemize]{itemindent=0ex,leftmargin=\leftskip+1em,nosep}

% Remark formatting.
% Use with \begin{remark}[breakable] to make it breakable across multiple pages.
% By default, the remark will be non-breakable.
%
% STYLE RULE:
%   SECTIONS THAT CONTAIN ONLY REMARKS ARE TO BE AVOIDED.
%   A remark is an optional part of the document. The text should make sense even if all remarks were to be
%   completely removed. For example, the following pattern should be avoided, because if we were to ignore
%   the remark, we'd end up with an empty section, which doesn't make sense:
%
%       \section{My section}
%       \begin{remark}
%           This is a remark, meaning that this text is not very important.
%       \end{remark}
%
% Instead, try to reformulate things so that the section would still make sense without the remark:
%
%       \section{My section}
%       Kill-o-Zap is to be a dangerous weapon.
%       \begin{remark}
%           Make it totally clear that this gun has a right end and a wrong end.
%           Make it totally clear to anyone standing at the wrong end that things are going badly for them.
%           This is not a gun for hanging over the fireplace or sticking in the umbrella stand,
%           it is a gun for going out and making people miserable with.
%       \end{remark}
\newenvironment{remark}[1][unbreakable]{
    % Disable overfull h-box warning
    % See https://tex.stackexchange.com/questions/13715/how-to-suppress-overfull-hbox-warnings-up-to-some-maximum
    \hfuzz=1em
    \begin{tcolorbox}[
        size=normal,
        left=1mm,
        right=1mm,
        top=1mm,
        bottom=1mm,
        colback=colorremarkbg,
        colframe=colorremarkframe,
        boxrule=0.5pt,
        toprule at break=0pt,
        bottomrule at break=0pt,
        sharp corners,
        width=\textwidth-\leftskip,
        enlarge top initially by=-1mm,
        #1
    ]
    \setlength{\parskip}{\DefaultParskip}
}{
    \end{tcolorbox}
    \hfuzz=0em      % Restore strict overflow warning
}

% Continuous footnote numbering
\counterwithout{footnote}{chapter}

% Discourage carrying a footnote to the next page
\interfootnotelinepenalty=1000

% We don't need to clear double page, ever. Shall the need arise, we'll have to implement a cleaner fix.
\renewcommand{\cleardoublepage}{\clearpage}

%
% Font specification.
%
\RequirePackage[T1]{fontenc}
\RequirePackage{fourier}        % Main font: Utopia Regular (serif); the monospace is ugly, so we override it later
\renewcommand*\ttdefault{txtt}  % Overriding the monospace font

%
% Page layout (tricky).
%
\newcommand{\DefaultParskip}{0.6em}
\raggedbottom
\RequirePackage[a4paper]{geometry}
\special{papersize=210mm,297mm}  % https://en.wikibooks.org/wiki/LaTeX/Page_Layout
\setlength\columnsep{6mm}        % Multi-column envoronments only
\setlength\headheight{17mm}
\setlength{\parskip}{\DefaultParskip}
\setlength{\abovecaptionskip}{0.2em}
\parindent=0em
\renewcommand{\baselinestretch}{1}
\renewcommand{\arraystretch}{1.1}
\leftskip=17mm
\headsep=8mm
\footskip=12mm
\geometry{margin=17mm,top=20mm,bottom=20mm}

% Removes the left margin for the next paragraph
\newcommand{\NoLeftSkip}{\parindent=-\leftskip}

% Allowing larger emergency stretch in order to avoid overfull boxes. More on the emergencystretch feature here:
% https://tex.stackexchange.com/questions/241343/what-is-the-meaning-of-fussy-sloppy-emergencystretch-tolerance-hbadness
\appto\fussy{\emergencystretch 5em}

%
% Section formatting
%
\setcounter{secnumdepth}{3}      % Increase this to add deeper structures

\titleformat{\part}[display]{}{\centering\Large Part \thepart}{1em}{\centering\huge\bfseries}
\titleformat{\chapter}{\huge\bfseries}{}{0em}{\makebox[17mm][l]{\thechapter}\hangindent=\leftskip}
\titleformat{\section}{\Large\bfseries}{}{0em}{\makebox[17mm][l]{\thesection}\hangindent=\leftskip}
\titleformat{\subsection}{\bfseries}{}{0em}{\makebox[17mm][l]{\thesubsection}\hangindent=\leftskip}
\titleformat{\subsubsection}{\itshape}{}{0em}{\makebox[17mm][l]{\thesubsubsection}\hangindent=\leftskip}

% Starred sections
\titleformat{name=\chapter,numberless}{\huge\bfseries}{}{0em}{}
\titleformat{name=\section,numberless}{\Large\bfseries}{}{0em}{}

% {left}{before}{after}[right]
\titlespacing{\chapter}{0em}{0em}{0em}
\titlespacing{\section}{0em}{0em}{0em}
\titlespacing{\subsection}{0em}{0em}{0em}
\titlespacing{\subsubsection}{0em}{0em}{0em}

%
% Hyperlinks.
%
\hypersetup{
    colorlinks,
    citecolor=colorhyperlink,
    filecolor=colorhyperlink,
    linkcolor=colorhyperlink,
    urlcolor=colorhyperlink
}

%
% Table of contents.
% Note that the title margins are defined in absolute units because we're using different font sizes.
%
\renewcommand{\contentsname}{Table of contents}
\renewcommand{\listfigurename}{List of figures}
\renewcommand{\listtablename}{List of tables}
\setcounter{tocdepth}{2}
\titlecontents{part}[0em]{\centering\bfseries}{}{}{}
\dottedcontents{chapter}[5mm]{\bfseries}{5mm}{1pc}
\dottedcontents{section}[14mm]{}{9mm}{1pc}
\dottedcontents{subsection}[25mm]{\footnotesize}{11mm}{1pc}

\dottedcontents{table}[3em]{}{3em}{1pc}
\dottedcontents{figure}[3em]{}{3em}{1pc}

% Custom styling of TOC, LOF, LOT.
% Using \sloppy in order to ensure that the maximum line length is not exceeded.
% Exceeding the line limit in two-column environments breaks the table of contents and wreaks havoc in general.
% More on this at https://kb.zubax.com/x/IYEh
\renewcommand\tableofcontents{%
    \thispagestyle{plain}%
    \sloppy%
    \section*{\contentsname}%
    \@starttoc{toc}%
    \fussy%
}
\renewcommand\listoffigures{%
    \thispagestyle{plain}%
    \sloppy%
    \section*{\listfigurename}%
    \@starttoc{lof}%
    \fussy%
}
\renewcommand\listoftables{%
    \thispagestyle{plain}%
    \sloppy%
    \section*{\listtablename}%
    \@starttoc{lot}%
    \fussy%
}

% Make links black in the TOC, LOF, LOT.
\preto\tableofcontents{\hypersetup{linkcolor=black}         \setlength{\parskip}{0em}}
\appto\tableofcontents{\hypersetup{linkcolor=colorhyperlink}\setlength{\parskip}{\DefaultParskip}}

\preto\listoffigures{\hypersetup{linkcolor=black}         \setlength{\parskip}{0em}}
\appto\listoffigures{\hypersetup{linkcolor=colorhyperlink}\setlength{\parskip}{\DefaultParskip}}

\preto\listoftables{\hypersetup{linkcolor=black}         \setlength{\parskip}{0em}}
\appto\listoftables{\hypersetup{linkcolor=colorhyperlink}\setlength{\parskip}{\DefaultParskip}}

% Include section numbers in the pdf bookmark tree.
\hypersetup{bookmarksnumbered}

%
% Table macros.
%

% Ensuring proper bottom spacing for multi-row cells.
% This requires the makecell package
% More at https://tex.stackexchange.com/a/378134/132781
\setcellgapes{1pt}
\makegapedcells

% Use this wrapper environment to define tables in it.
% This environment provides proper placement of the table within the page, and the properly positioned caption.
\NewDocumentEnvironment{CyphalTableWrapper}{ o m }{%
    \ifthenelse{\equal{#1}{wide}}{
        \NoLeftSkip
        \begin{minipage}{\textwidth}  % Minipage is needed to prevent page breaks after the caption
    }{
        \begin{minipage}{\textwidth-\leftskip}  % Minipage is needed to prevent page breaks after the caption
    }
        \begin{ThreePartTable}
}{
            % If hypcap is enabled, the package "caption" yields a warning saying that the option will be ignored,
            % ostensibly because we don't have the hypcap package loaded (we don't need this behavior).
            % RTFM https://www.texlive.info/CTAN/macros/latex/contrib/caption/caption-rus.pdf.
            \captionsetup{hypcap=false}
            % https://tex.stackexchange.com/questions/3243/why-should-a-table-caption-be-placed-above-the-table
            \captionof{table}{#2}
        \end{ThreePartTable}
    \end{minipage}
}

\newenvironment{CyphalCompactTable}[1]{
    \begin{tabu}{#1}
        \hline
        \everyrow{\hline}
        \rowfont{\bfseries}
}{
    \end{tabu}
}

% Use this environment to define a table within the wrapper environment defined above.
\newenvironment{CyphalWrappedTable}[1]{
    \begin{tabu} to \textwidth {#1}
        \hline
        \everyrow{\hline}
        \rowfont{\bfseries}
}{
    \end{tabu}
}

% This is a shortcut that places a table within the wrapper environment.
% Use it in all cases unless you need to define table notes, or if you need to customize something.
% Arguments:
%   {Table caption}{format}
% Example:
%   \begin{CyphalSimpleTable}{Firmware status indication via RGB LED}{|l l|X|}
\newenvironment{CyphalSimpleTable}[3][]{
    \begin{CyphalTableWrapper}[#1]{#2}
        \begin{CyphalWrappedTable}{#3}
}{
        \end{CyphalWrappedTable}
    \end{CyphalTableWrapper}
}

%
% Page styling.
%
\newcommand\ChapterTitleWithNumber{%
    \ifthenelse{\equal{\thechapter}{0}}%
    {}%
    {\thechapter.\ }%
    \ifdefempty{\chaptertitle}%
    {\sectiontitle}%
    {\chaptertitle}%
}

\newcommand\PageNumberWithTotal{\thepage\if@mainmatter/\pageref*{LastPage}\fi}

\newcommand\CyphalLogo[1][15mm]{\includegraphics[width=#1]{cyphal_logo}}

\newcommand\VerboseLinkToSupportForum{Support \& feedback: \href{http://opencyphal.org}{opencyphal.org}}

\newcommand\TitleWithDateBefore{\begin{footnotesize}\today\quad\end{footnotesize}{\@title}}
\newcommand\TitleWithDateAfter{{\@title}\begin{footnotesize}\quad\today\end{footnotesize}}

\renewpagestyle{plain}{
    \sethead%
        [\TitleWithDateAfter][][\CyphalLogo]     % even
        {\CyphalLogo}{}{\TitleWithDateBefore}    % odd

    \setfoot%
        [\PageNumberWithTotal][\small\VerboseLinkToSupportForum][\small\CyphalCopyright]
        {\small\CyphalCopyright}{\small\VerboseLinkToSupportForum}{\PageNumberWithTotal}

    \headrule
    \footrule
}
\newpagestyle{main}{
    \sethead%
        [\TitleWithDateAfter][][\CyphalLogo]     % even
        {\CyphalLogo}{}{\TitleWithDateBefore}    % odd

    \setfoot%
        [\PageNumberWithTotal][][\small\ChapterTitleWithNumber]
        {\small\ChapterTitleWithNumber}{}{\PageNumberWithTotal}

    \headrule
    \footrule
}
\newpagestyle{titlepage}{
    \setfoot{\CyphalCopyright}{}{\VerboseLinkToSupportForum}
    \footrule
}

% Use the same style on pages that open new chapters.
\patchcmd{\chapter}{plain}{main}{}{}

% The document will switch to the proper page style automatically.
% We also take this opportunity to enforce \fussy in the main matter.
\preto\frontmatter{\twocolumn\pagestyle{plain}}
\preto\mainmatter{\onecolumn\pagestyle{main}\fussy}
\preto\backmatter{\onecolumn\pagestyle{plain}}

%
% Title page environment.
% Use "\BeginRightColumn" to switch to the right column.
%
\newcommand{\BeginRightColumn}{\vfill\eject}

\newcommand{\RenderTitlePageHeader}{%
    \renewcommand{\baselinestretch}{1}
    \CyphalLogo[\textwidth]\hfill\vspace{10mm}
    \begin{flushleft}\begin{Huge}\@title\end{Huge}\end{flushleft}
    Revision \today\\[10mm]
}

\renewenvironment{titlepage}{%
    \leftskip=0mm\parindent=0mm
    \pagestyle{titlepage}\thispagestyle{titlepage}
    \twocolumn[%
        \begin{@twocolumnfalse}
            \RenderTitlePageHeader
        \end{@twocolumnfalse}
    ]
    % This is needed to allow LaTeX add more white spaces to avoid overflowing lines.
    % Extra white spaces in two-column environments are much less bad than overflowing lines.
    \emergencystretch 10em
}{%
    \clearpage
}

\endinput
