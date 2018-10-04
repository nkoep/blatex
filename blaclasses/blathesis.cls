% Copyright (c) 2014-2017 Niklas Koep
%
% This software may be modified and distributed under the terms of the MIT
% license. See the LICENSE file for details.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{blathesis}[2014/05/17]

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
\usepackage{microtype}
\usepackage[dvipsnames]{xcolor}
\usepackage{hyperref}

% Configure the hyperref package.
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

% Page layout
\usepackage[
  left=3.25cm,
  right=3.25cm,
  top=3.2cm,headsep=0.5cm,
  bottom=5cm,footskip=1.5cm
]{geometry}

% Header/footer
\usepackage{fancyhdr}
\fancypagestyle{fancythesis}{
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \fancyhead[RO]{\selectfont\scshape\nouppercase{\rightmark}}
  \fancyhead[LE]{\selectfont\scshape\nouppercase{\leftmark}}
  \fancyfoot[LE,RO]{\thepage}
}

\usepackage{titlesec}
\titleformat{\chapter}[display]{\sffamily\Large}{%
  \rmfamily\bfseries\filcenter\fontsize{125}{1}\selectfont\thechapter%
}{6ex}{\titlerule\vspace{1.5ex}\filcenter}[\vspace{1.5ex}\titlerule]
\titleformat{\section}{\raggedright\bfseries\Large}{\thesection}{1em}{}

% Start chapters on odd pages and make sure the preceeding page is empty.
\let\@cleardoublepage\cleardoublepage
\newcommand*{\clearemptydoublepage}{%
  \clearpage{%
    \pagestyle{empty}%
    \@cleardoublepage%
  }%
}
\renewcommand{\chapter}{%
  \clearemptydoublepage       % Starts new page.
  \thispagestyle{empty}       % Page style of chapter page is 'plain'
  \global\@topnum\z@          % Prevents figures from going at top of page
  \@afterindentfalse          % Suppresses indent in first paragraph
  \secdef\@chapter\@schapter
}

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

% Configure the bibliography style
\bibliographystyle{alpha}
\let\@bibliography\bibliography
\renewcommand{\bibliography}[1]{
  \renewcommand{\bibname}{References}
  \@bibliography{#1}
  \addcontentsline{toc}{chapter}{References}
}

% TODO: Finish the title page.
\renewcommand{\maketitle}{
  \begin{titlepage}
    \centering
    \vspace{2.5cm}
    {\Large\sffamily\@title\unskip\strut\par}
    \vspace{5cm}
    {\Large\@author\unskip\strut\par}
    \vfill
    {\large\@date\par}
  \end{titlepage}
}

\RequirePackage{blatex}

\endinput
