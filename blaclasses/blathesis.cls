% Copyright (c) 2014-2017 Niklas Koep
%
% This software may be modified and distributed under the terms of the MIT
% license. See the LICENSE file for details.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{blathesis}[2014/05/17]

\newif\if@final\@finalfalse
\DeclareOption{final}{
  \@finaltrue
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
  left=2.75cm,
  right=2.75cm,
  top=2.5cm,
  headsep=0.75cm,
  bottom=4.25cm,
  footskip=1.5cm
]{geometry}

% Define bibliography style.
\usepackage[
  backend=biber,
  style=alphabetic,
  sorting=nyt
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
\def\@barseparator{~~\textcolor{gray}{|}~~}
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
  {\sffamily\LARGE}
  {\filcenter\rmfamily\bfseries\fontsize{120pt}{150pt}\selectfont\thechapter}
  {6ex}
  {\titlerule\vspace{1.5ex}\filcenter}
  [\vspace{1.5ex}\titlerule]
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

\renewcommand{\maketitle}{
  \title{\Title}
  \author{\Author}
  \Env{titlepage}{
    \centering
    {\Huge\@title}

    \vspace{35mm}

    \if@final
        Von der Fakultät für Elektrotechnik und Informationstechnik \\
        der Rheinisch-Westfälischen Technischen Hochschule Aachen \\
        zur Erlangung des akademischen Grades eines Doktors \\
        der Ingenieurwissenschaften genehmigte Dissertation

        \vspace{20mm}

        vorgelegt von
        \vspace{5mm}
    \else
        % Statement for submission version
        Der Fakultät für Elektrotechnik und Informationstechnik \\
        der Rheinisch-Westfälischen Technischen Hochschule Aachen \\
        vorgelegte Dissertation zur Erlangung \\
        des akademischen Grades eines Doktors \\
        der Ingenieurwissenschaften

        \vspace{25mm}
    \fi

    \AuthorDegree \\
    \@author \\
    \vspace{5mm}
    aus \AuthorBirthplace \\

    \if@final
        \vspace{20mm}
        \begin{tabular}{ll}
          Berichter: & \Examiner \\
                     & \SecondExaminer
        \end{tabular}
        \vspace{20mm}

        Tag der mündlichen Prüfung: \ExaminationDate

        \vspace{30mm}
        Diese Dissertation ist auf den Internetseiten \\
        der Hochschulbibliothek online verfügbar.
    \fi
  }
}

\raggedbottom

\RequirePackage{blatex}

\endinput
