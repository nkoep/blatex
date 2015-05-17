\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{blathesis}[2014/05/17]

\DeclareOption*{
  \PassOptionsToPackage{\CurrentOption}{blatex}
}

\ProcessOptions\relax

\LoadClass[12pt,a4paper,twoside]{book}

\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage[english]{babel}
\usepackage[babel=true]{microtype}
\usepackage{lmodern}
\usepackage{fix-cm}
\usepackage{microtype}

% Page layout
\usepackage[
  left=2.9cm,
  right=4cm,
  top=3.2cm,headsep=0.5cm,
  bottom=5cm,footskip=1.5cm
]{geometry}

% Header/footer
\usepackage{fancyhdr}
\fancypagestyle{fancythesis}{
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \fancyhead[RO]{\selectfont\itshape\nouppercase{\rightmark}}
  \fancyhead[LE]{\selectfont\nouppercase{\leftmark}}
  \fancyfoot[LE,RO]{\thepage}
}

\usepackage{titlesec}
% TODO: Use em units rather than ex.
\titleformat{\chapter}[display]{\bfseries\LARGE}{%
  \filcenter\fontsize{125}{1}\selectfont\thechapter
}{6ex}{\titlerule\vspace{1.5ex}\filcenter}[\vspace{1.5ex}\titlerule]
\titleformat{\section}{\bfseries\Large}{\thesection}{1em}{}

% Configure the hyperref package.
\usepackage[usenames,dvipsnames]{xcolor}
\def\@linkcolor{NavyBlue}
\usepackage[
  final,
  linktocpage=true,
  colorlinks=true,
  linkcolor=\@linkcolor,
  citecolor=\@linkcolor,
  filecolor=\@linkcolor,
  urlcolor=\@linkcolor
]{hyperref}

% Start chapters on odd pages and make sure the preceeding page is empty.
\let\@cleardoublepage\cleardoublepage
\newcommand*{\clearemptydoublepage}{%
  \clearpage{%
    \pagestyle{empty}%
    \@cleardoublepage%
  }%
}
\def\chapter{%
  \clearemptydoublepage % Starts new page.
  \thispagestyle{empty}    % Page style of chapter page is 'plain'
  \global\@topnum\z@        % Prevents figures from going at top of page.
  \@afterindentfalse        % Suppresses indent in first paragraph.  Change
  \secdef\@chapter\@schapter% to \@afterindenttrue to have indent.
}

% Redefine the \listoftables macro so that it adds a TOC entry as well
\let\@listoftables\listoftables
\renewcommand{\listoftables}{%
  \@listoftables%
  \addcontentsline{toc}{chapter}{\listtablename}%
}

% Redefine the \listoffigures macro so that it adds a TOC entry as well
\let\@listoffigures\listoffigures
\renewcommand{\listoffigures}{%
  \@listoffigures%
  \addcontentsline{toc}{chapter}{\listfigurename}%
}

\RequirePackage{blatex}

\endinput

