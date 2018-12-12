%
% Copyright (c) 2017-2018  Zubax Robotics OU  <info@zubax.com>
%
% Author: Pavel Kirienko <pavel.kirienko@zubax.com>
%

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{uavcandoc}[2018/06/29 UAVCAN document class]

\LoadClass[a4paper,onecolumn,openany]{book}

\author{UAVCAN Development Team}

\RequirePackage{lipsum}              % Lorem ipsum text generation, useful for testing.
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
\usepackage[most]{tcolorbox}

%
% Minor definitions.
%
\definecolor{colorhyperlink}{RGB}{0,0,200}
\definecolor{colorlogo}{RGB}{0,124,195}
\definecolor{colorlogolight}{RGB}{220, 242, 255}

\renewcommand{\dateseparator}{.}

\sisetup{range-phrase = \text{--}}

\newcommand\UAVCANCopyright{\copyright{} 2015--\the\year{} \href{http://uavcan.org}{\@author}}

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
xleftmargin=\dimexpr\leftskip-2mm\relax,
framesep=2mm,
autogobble
}
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
\setlist[enumerate]{leftmargin=\leftskip,itemindent=1.4em,nosep}
\setlist[itemize]{leftmargin=\leftskip,itemindent=1em,nosep}

% Remark formatting.
% Use with \begin{remark}[breakable] to make it breakable across multiple pages.
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
        colback=colorlogolight,
        colframe=colorlogo,
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

% We don't need to clear double page, ever. Shall the need arise, we'll have to implement a cleaner fix.
\renewcommand{\cleardoublepage}{\clearpage}

%
% Font specification.
%
\RequirePackage[sfdefault]{roboto}   % Option 'sfdefault' only if the base font of the document is to be sans serif
\RequirePackage[T1]{fontenc}
\RequirePackage{inconsolata}

%
% Page layout (tricky).
%
\newcommand{\DefaultParskip}{0.9em}
\raggedbottom
\RequirePackage[a4paper]{geometry}
\special{papersize=210mm,297mm}  % https://en.wikibooks.org/wiki/LaTeX/Page_Layout
\setlength\columnsep{6mm}        % Multi-column envoronments only
\setlength\headheight{17mm}
\setlength{\parskip}{\DefaultParskip}
\setlength{\abovecaptionskip}{0.2em}
\parindent=0em
\renewcommand{\baselinestretch}{1.2}
\renewcommand{\arraystretch}{1.2}
\leftskip=17mm
\headsep=8mm
\footskip=12mm
\geometry{margin=20mm,top=20mm,bottom=20mm}

% Removes the left margin for the next paragraph
\newcommand{\NoLeftSkip}{\parindent=-\leftskip}

% Allowing larger emergency stretch in order to avoid overfull boxes. More on the emergencystretch feature here:
% https://tex.stackexchange.com/questions/241343/what-is-the-meaning-of-fussy-sloppy-emergencystretch-tolerance-hbadness
\appto\fussy{\emergencystretch 5em}

%
% Section formatting
%
\setcounter{secnumdepth}{3}      % Increase this to add deeper structures

\titleformat{\part}[display]{}{\centering\Large Part \thepart}{1em}{
    \centering\huge\bfseries
    }

\titleformat{\chapter}{\huge\bfseries}{}{1em}{\makebox[17mm][l]{\thechapter}\hangindent=17mm}
\titleformat{\section}{\Large\bfseries}{}{1em}{\makebox[17mm][l]{\thesection}\hangindent=17mm}
\titleformat{\subsection}{\bfseries}{}{1em}{\makebox[17mm][l]{\thesubsection}\hangindent=17mm}
\titleformat{\subsubsection}{\itshape}{\thesubsubsection}{1em}{%
    \makebox[17mm][l]{\thesubsubsection}\hangindent=17mm
    }

% Starred sections
\titleformat{name=\chapter,numberless}{\huge\bfseries}{}{1em}{}
\titleformat{name=\section,numberless}{\Large\bfseries}{}{1em}{}

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
\dottedcontents{chapter}[10mm]{\bfseries}{10mm}{1pc}
\dottedcontents{section}[20mm]{}{10mm}{1pc}
\dottedcontents{subsection}[30mm]{\small}{10mm}{1pc}

\dottedcontents{table}[2em]{}{2em}{1pc}
\dottedcontents{figure}[2em]{}{2em}{1pc}

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
\newenvironment{UAVCANTableWrapper}[1]{
    \NoLeftSkip
    \begin{minipage}{\textwidth}  % Minipage is needed to prevent page breaks after the caption
        \begin{ThreePartTable}
            % https://tex.stackexchange.com/questions/3243/why-should-a-table-caption-be-placed-above-the-table
            \captionof{table}{#1}
}{
        \end{ThreePartTable}
    \end{minipage}
}

\newenvironment{UAVCANCompactTable}[1]{
    \begin{tabu}{#1}
        \hline
        \everyrow{\hline}
        \rowfont{\bfseries}
}{
    \end{tabu}
}

% Use this environment to define a table within the wrapper environment defined above.
\newenvironment{UAVCANWrappedTable}[1]{
    \NoLeftSkip
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
%   \begin{UAVCANSimpleTable}{Firmware status indication via RGB LED}{|l l|X|}
\newenvironment{UAVCANSimpleTable}[2]{
    \begin{UAVCANTableWrapper}{#1}
        \begin{UAVCANWrappedTable}{#2}
}{
        \end{UAVCANWrappedTable}
    \end{UAVCANTableWrapper}
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

\newcommand\UAVCANLogo[1][15mm]{\includegraphics[width=#1]{uavcan_logo}}

\newcommand\VerboseLinkToSupportForum{Support \& feedback: \href{http://uavcan.org}{uavcan.org}}

\newcommand\TitleWithDateBefore{\begin{footnotesize}\today\quad\end{footnotesize}{\@title}}
\newcommand\TitleWithDateAfter{{\@title}\begin{footnotesize}\quad\today\end{footnotesize}}

\renewpagestyle{plain}{
    \sethead%
        [\TitleWithDateAfter][][\UAVCANLogo]     % even
        {\UAVCANLogo}{}{\TitleWithDateBefore}    % odd

    \setfoot%
        [\PageNumberWithTotal][\small\VerboseLinkToSupportForum][\small\UAVCANCopyright]
        {\small\UAVCANCopyright}{\small\VerboseLinkToSupportForum}{\PageNumberWithTotal}

    \headrule
    \footrule
    }
\newpagestyle{main}{
    \sethead%
        [\TitleWithDateAfter][][\UAVCANLogo]     % even
        {\UAVCANLogo}{}{\TitleWithDateBefore}    % odd

    \setfoot%
        [\PageNumberWithTotal][][\small\ChapterTitleWithNumber]
        {\small\ChapterTitleWithNumber}{}{\PageNumberWithTotal}

    \headrule
    \footrule
    }
\newpagestyle{titlepage}{
    \setfoot{\UAVCANCopyright}{}{\VerboseLinkToSupportForum}
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
    \UAVCANLogo[\textwidth]\hfill\vspace{10mm}
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
