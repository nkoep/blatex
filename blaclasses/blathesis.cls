% Copyright (c) 2014-2017 Niklas Koep
%
% This software may be modified and distributed under the terms of the MIT
% license. See the LICENSE file for details.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{blathesis}[2014/05/17]

\newif\if@publication\@publicationfalse
\DeclareOption{publication}{
  \@publicationtrue
}

\DeclareOption*{
  \PassOptionsToPackage{\CurrentOption}{blatex}
}

\ProcessOptions\relax

\LoadClass[11pt,a4paper,dvipsnames,twoside]{book}

\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage[english]{babel}
\usepackage[babel=true]{microtype}
\usepackage{lmodern}
\usepackage{fix-cm}
\usepackage{microtype}
\usepackage[dvipsnames]{xcolor}

% Miscellaneous packages
\usepackage{units}        % Properly formatted units
\usepackage{gensymb}      % Degree symbol
\usepackage{textcomp}     % Only loaded to make gensymb shut up...
\usepackage{graphicx}     % Provides the subfig environment
\usepackage[labelfont=bf,font={small,sf}]{caption}
\usepackage{subcaption}
\usepackage{csquotes}     % Provides \enquote{} command to quote text
\usepackage{float}        % Adds option "h" to place floats where they are used
\usepackage{pgfplots}
\usepackage{pgfplotstable}
\usepackage{tikzscale}

% Page layout
\usepackage[
  left=2.75cm,
  right=2.75cm,
  bindingoffset=0.75cm,
  top=3.5cm,
  headsep=0.75cm,
  bottom=3.75cm,
  footskip=1.25cm,
  headheight=48pt,
  heightrounded
]{geometry}

% Define bibliography style.
\usepackage[
  backend=biber,
  style=alphabetic,
  sorting=nyt,
  maxbibnames=10
]{biblatex}
\DefineBibliographyStrings{english}{
  bibliography = {References}
}
% Use superscript plus sign for citation labels in case of multiple authors.
\renewcommand*{\labelalphaothers}{\textsuperscript{+}}
% Use boldface citation labels.
\DeclareFieldFormat{labelalpha}{\mkbibbold{#1}}
\DeclareFieldFormat{extraalpha}{\mkbibbold{\mknumalph{#1}}}

% Set up header and footer.
\usepackage{fancyhdr}
\fancypagestyle{blathesis}{
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \fancyhead[RO]{\selectfont\scshape\nouppercase{\rightmark}}
  \fancyhead[LE]{\selectfont\scshape\nouppercase{\leftmark}}
  \fancyfoot[LE,RO]{\thepage}
}
\pagestyle{fancy}
\def\@barseparator{~~\textcolor{gray}{\textbf{|}}~~}
\renewcommand{\sectionmark}[1]{\markright{\thesection\@barseparator#1}}
\renewcommand{\chaptermark}[1]{%
  \markboth{\chaptername~\thechapter\@barseparator#1}{}%
}

% Start chapters on odd pages and make sure the preceeding page is empty.
\newcommand*{\clearemptydoublepage}{%
  \clearpage%
  \thispagestyle{empty}%
  \cleardoublepage%
}
\renewcommand{\chapter}{%
  \clearemptydoublepage       % Starts new page.
  \thispagestyle{empty}       % Page style of chapter page is 'plain'
  \global\@topnum\z@          % Prevents figures from going at top of page
  \@afterindentfalse          % Suppresses indent in first paragraph
  \secdef\@chapter\@schapter%
}

\usepackage{titlesec}
\titleformat
  {\chapter}
  [display]
  {\sffamily\huge}
  {\filcenter\rmfamily\bfseries\fontsize{120pt}{150pt}\selectfont\thechapter}
  {6ex}
  {{\titlerule[1pt]}\vspace{1.5ex}\filcenter}
  [\vspace{1.5ex}{\titlerule[1pt]}\vspace{%
    0pt plus 0.5\baselineskip minus 0.5\baselineskip}]
\titleformat
  {\section}
  {\raggedright\sffamily\bfseries\Large}
  {\thesection}
  {1em}
  {}
\titleformat
  {\subsection}
  {\raggedright\sffamily\large}
  {\thesubsection}
  {1em}
  {}
\titleformat
  {\subsubsection}
  {\raggedright\sffamily\bfseries}
  {\thesubsubsection}
  {1em}
  {}

% Redefine the \listoftables macro so that it adds a TOC entry as well
\let\@listoftables\listoftables
\renewcommand{\listoftables}{
  \addcontentsline{toc}{chapter}{\listtablename}
  \@listoftables
}

% Redefine the \listoffigures macro so that it adds a TOC entry as well
\let\@listoffigures\listoffigures
\renewcommand{\listoffigures}{
  \addcontentsline{toc}{chapter}{\listfigurename}
  \@listoffigures
}

\usepackage{hyperref}

% Configure the hyperref package.
\if@publication
  \def\@linkcolor{LimeGreen}
\else
  \def\@linkcolor{NavyBlue}
\fi
\hypersetup{
  final,
  linktocpage=true,
  colorlinks=true,
  linkcolor=\@linkcolor,
  citecolor=\@linkcolor,
  filecolor=\@linkcolor,
  urlcolor=\@linkcolor
}

\renewcommand{\maketitle}{
  \title{\Title}
  \author{\Author}
  \Env{titlepage}{
    \centering
    {\Huge\@title}

    \vspace{3cm}

    \if@publication
        Von der Fakultät für Elektrotechnik und Informationstechnik \\
        der Rheinisch-Westfälischen Technischen Hochschule Aachen \\
        zur Erlangung des akademischen Grades eines \\[1cm]

        Doktors der Ingenieurwissenschaften \\[1cm]

        genehmigte Dissertation

        \vspace{2cm}

        vorgelegt von
        \vspace{0.5cm}
    \else
        % Statement for submission version
        Der Fakultät für Elektrotechnik und Informationstechnik \\
        der Rheinisch-Westfälischen Technischen Hochschule Aachen \\
        vorgelegte Dissertation zur Erlangung \\
        des akademischen Grades eines \\[1cm]

        Doktors der Ingenieurwissenschaften

        \vspace{2.5cm}
    \fi

    \@author \\
    \vspace{5mm}
    aus \AuthorBirthplace \\

    \if@publication
        \vspace{2cm}
        \begin{tabular}{ll}
          Berichter: & \Examiner \\
                     & \SecondExaminer
        \end{tabular}
        \vspace{2cm}

        Tag der mündlichen Prüfung: \ExaminationDate

        \vspace*{\fill}
        Diese Dissertation ist auf den Internetseiten \\
        der Hochschulbibliothek online verfügbar.
    \fi
  }
}

\RequirePackage{blatex}

\endinput
