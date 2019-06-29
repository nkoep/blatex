% Copyright (c) 2014-2017 Niklas Koep
%
% This software may be modified and distributed under the terms of the MIT
% license. See the LICENSE file for details.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{blathesis}[2014/05/17]

\newif\ifpublication\publicationfalse
\DeclareOption{publication}{
  \publicationtrue
}

\newif\ifprint\printfalse
\DeclareOption{print}{
  \printtrue
}

\DeclareOption*{
  \PassOptionsToPackage{\CurrentOption}{blatex}
}

\ProcessOptions\relax

\LoadClass[12pt,a4paper,dvipsnames,twoside]{book}

\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage[english]{babel}
\usepackage[babel=true]{microtype}
\usepackage{lmodern}
\usepackage{fix-cm}
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
\usepackage{etoolbox}

% Page layout
\ifprint
  \def\@BindingOffset{0.75cm}
  \def\@Margin{2cm}
\else
  \def\@BindingOffset{0cm}
  \def\@Margin{2.375cm}
\fi
\usepackage[
  includehead,
  includefoot,
  bindingoffset=\@BindingOffset,
  margin=\@Margin,
  top=1.75cm,
  bottom=2cm,
  heightrounded,
  headheight=14pt
]{geometry}

% Define bibliography style.
\usepackage[
  backend=biber,
  style=alphabetic,
  maxbibnames=10,
  giveninits=true,
  doi=false,
  url=false
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
  \fancyhead[RO]{\small\selectfont\scshape\nouppercase{\rightmark}}
  \fancyhead[LE]{\small\selectfont\scshape\nouppercase{\leftmark}}
  \fancyfoot[LE,RO]{\small\thepage}
}
\pagestyle{fancy}
\def\@barseparator{~~\textcolor{gray}{\upshape\textbf{|}}~~}
\renewcommand{\sectionmark}[1]{\markright{\thesection\@barseparator#1}}
\renewcommand{\chaptermark}[1]{%
  \markboth{\chaptername~\thechapter\@barseparator#1}{}%
}

\patchcmd{\chapter}{plain}{empty}{}{}
\patchcmd{\part}{plain}{empty}{}{}

\usepackage[clearempty]{titlesec}
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

\usepackage[nottoc]{tocbibind}
\usepackage{hyperref}

% Configure the hyperref package.
\ifprint
  \hypersetup{hidelinks}
\else
  \def\@linkcolor{NavyBlue}
  \hypersetup{
    final,
    linktocpage=true,
    colorlinks=true,
    linkcolor=\@linkcolor,
    citecolor=\@linkcolor,
    filecolor=\@linkcolor,
    urlcolor=\@linkcolor
  }
\fi

\renewcommand{\maketitle}{
  \title{\Title}
  \author{\Author}
  \Env{titlepage}{
    \centering
    {\Huge\@title}

    \vspace{3cm}

    \ifpublication
        Von der Fakultät für Elektrotechnik und Informationstechnik \\
        der Rheinisch-Westfälischen Technischen Hochschule Aachen \\
        zur Erlangung des akademischen Grades eines \\[1cm]

        Doktors der Ingenieurwissenschaften \\[1cm]

        genehmigte Dissertation%

        \vspace{2cm}

        vorgelegt von%
        \vspace{0.5cm}
    \else
        % Statement for submission version
        Der Fakultät für Elektrotechnik und Informationstechnik \\
        der Rheinisch-Westfälischen Technischen Hochschule Aachen \\
        vorgelegte Dissertation zur Erlangung \\
        des akademischen Grades eines \\[1cm]

        Doktors der Ingenieurwissenschaften%

        \vspace{2.5cm}
    \fi

    \@author \\
    \vspace{5mm}
    aus \AuthorBirthplace \\

    \ifpublication
        \vspace{2cm}
        \begin{tabular}{ll}
          Berichter: & \Examiner \\
                     & \SecondExaminer%
        \end{tabular}
        \vspace{2cm}

        Tag der mündlichen Prüfung: \ExaminationDate%

        \vspace*{\fill}
        Diese Dissertation ist auf den Internetseiten \\
        der Universitätsbibliothek online verfügbar.%
    \fi
  }
}

\RequirePackage{blatex}

\endinput
