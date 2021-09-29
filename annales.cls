\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{annales}[2021/02/17 Annales template, samnuutt@utu.fi]

%% PDF/A stuff follows
%
% set version to PDF 1.7
\pdfminorversion=7
% PDF/A requires color profile information
\immediate\pdfobj stream attr{/N 3^^J/Alternate/DeviceRGB} file{sRGB.icc}
\pdfcatalog{
  /PageMode /UseNone
  /OutputIntents [
    <<
      /Type /OutputIntent
      /S /GTS_PDFA1
      /DestOutputProfile \the\pdflastobj\space 0 R
      /OutputConditionIdentifier (sRGB IEC61966-2.1)
      /Info(sRGB IEC61966-2.1)
      /RegistryName (http://www.color.org/)
    >>
  ]
}
% PDF/A requires glyph mappings to unicode
\input{glyphtounicode.tex}
\pdfgentounicode=1

%% set default font size
%
\newcommand{\@defaultfontsize}{11pt}

%% This is a kind of book, so pass options and load it
%
\ProcessOptions
\PassOptionsToClass{\@defaultfontsize}{book}
\PassOptionsToClass{b5paper}{book}
\PassOptionsToClass{openany}{book}
\LoadClass{book}

%% Load some packages we'll use
%
\RequirePackage[utf8]{inputenc}
\RequirePackage[textheight=202mm,top=24mm,inner=24mm,outer=22mm]{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{tocloft}
\RequirePackage{tocbibind}
\RequirePackage{natbib}
\RequirePackage{colortbl}
\RequirePackage{caption}
\RequirePackage{chngcntr}
\RequirePackage{wrapfig}
\RequirePackage[contents={},opacity=1,scale=1,color=black]{background}
\RequirePackage{tikzpagenodes}
\RequirePackage[english,finnish,russian]{babel}
\RequirePackage[pdfa=true]{hyperref}
\RequirePackage{hyperxmp}% include XMP metadata (PDF/A)
\RequirePackage{cmap}% make sure doc is searchable (PDF/A)
%\RequirePackage{lastpage}

%% fix page size and margins etc. according to the graphical guideline
%
% LaTeX's funky page model is something like the following...
%
% · page width: 
% 1inch            +
% \hoffset         +
% \oddsidemargin   +
% \textwidth       +
% \marginsep       +
% \marginparwidth
% 
% · page height: 
% 1inch            +
% \voffset         +
% \topmargin       +
% \headheight      +
% \headsep         +
% \textheight      +
% \footnotesep     +
% \footheigth 
% 
% · 1 pt == 1/72 inch == 0.35 mm
% 
%  We'll need inside 24mm, outside 22mm, textarea 130mmx202mm
%             top 10mm, 24mm, etc.
%
%  Luckily most are already set by geometry package above
%
\setlength{\headheight}{12pt}
\setlength{\headsep}{9.8mm}%24mm - 10mm - 10pt
\setlength{\parindent}{6mm}
% for later save&restore use
\newlength{\orig}

%% Fonts: Helvetica (Arial), Times and Courier
%
\renewcommand{\sfdefault}{phv}
\renewcommand{\rmdefault}{ptm}
\renewcommand{\ttdefault}{pcr}
% graphical guidelines state body text as times 11pt/14pt
\renewcommand{\normalfont}{\fontfamily{ptm}\fontsize{11}{14}\selectfont}


%% Set headers and footers
%
\pagestyle{fancy}
\renewcommand{\headrulewidth}{0 pt}
\setlength{\headwidth}{\textwidth}
\newcommand{\helvhead}{\fontfamily{phv}\fontsize{8.5}{10}\selectfont}
\newcommand{\helvfoot}{\fontfamily{phv}\fontsize{12}{12}\selectfont}
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\fancyhead[LO]{}
\fancyhead[RO]{\helvhead\leftmark}
\fancyhead[LE]{\helvhead\Author}
\fancyhead[RE]{}
\fancyfoot[LE,RO]{\helvfoot\thepage}
\fancyfoot[C]{}
% 1st pages of chapters use plain style so set it as well
\fancypagestyle{plain}{
  \renewcommand{\headrulewidth}{0 pt}
  \fancyhf{}
  \fancyfoot[LE,RO]{\helvfoot\thepage}
}


%% Get rid of Luku/Chapter text at the beginning of each chapter
%  and make other changes that are specified in style guide
%
\makeatletter
\renewcommand{\@chapapp}{\relax}
\renewcommand{\@makechapterhead}[1]{%
  {\parindent \z@ \raggedright \normalfont
   \ifnum \c@secnumdepth >\m@ne
        \fontfamily{phv}\fontsize{20}{20}\selectfont\thechapter\space\space
    \fi
    \interlinepenalty\@M
    #1\par\nobreak
    \vskip 32mm %\p@ % 24mm+20pt+32mm ~= 65mm to 1st paragraph¹
  }}
\renewcommand{\@makeschapterhead}[1]{%
    {\parindent \z@\raggedright
      \fontfamily{phv}\fontsize{20}{20}\selectfont
      \interlinepenalty\@M
      #1\par\nobreak
    \vskip 32mm %\p@
  }}
\makeatother
% ¹ This will obviously blow up in our face if the heading is more than
% one line, but lets tackle that when we get there. One remedy could be
% to manually "roll back" by suitable amount with a construct something
% like \rule{0pt}{0pt}\\[-2.5\baselineskip] before the next paragraph or
% \section command


%% define font, fontsize and spacing for various section headings
%
\makeatletter
\renewcommand{\section}{
  \@startsection {section}{1}{\z@}%
  {-20pt}%
  {7pt}%
  {\fontfamily{phv}\fontsize{15}{14}\selectfont}}
\renewcommand{\subsection}{
  \@startsection{subsection}{2}{\z@}%
  {-20pt}%
  {7pt}%
  {\fontfamily{phv}\fontsize{13}{14}\selectfont}}
\renewcommand{\subsubsection}{
  \@startsection{subsubsection}{3}{\z@}%
  {-20pt}%
  {7pt}%
  {\fontfamily{phv}\fontsize{11}{14}\selectfont}}
\makeatother

%% dotted contentsline for chapters, fonts&sizes etc. for ToC, LoT, LoF
%
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftbeforetoctitleskip}{-\baselineskip}
\renewcommand{\cftaftertoctitleskip}{32mm}
\renewcommand{\cftbeforelottitleskip}{-\baselineskip}
\renewcommand{\cftafterlottitleskip}{32mm}
\renewcommand{\cftbeforeloftitleskip}{-\baselineskip}
\renewcommand{\cftafterloftitleskip}{32mm}
\renewcommand{\cfttoctitlefont}{\fontfamily{phv}\fontsize{20}{20}\selectfont}
\renewcommand{\cftlottitlefont}{\fontfamily{phv}\fontsize{20}{20}\selectfont}
\renewcommand{\cftloftitlefont}{\fontfamily{phv}\fontsize{20}{20}\selectfont}
\renewcommand{\cftchapfont}{\fontfamily{phv}\fontsize{12}{13}\selectfont\bfseries}
\renewcommand{\cftsecfont}{\fontfamily{phv}\fontsize{11}{11}\selectfont}
\renewcommand{\cftsubsecfont}{\fontfamily{phv}\fontsize{11}{11}\selectfont}
\renewcommand{\cfttabfont}{\fontfamily{phv}\fontsize{11}{11}\selectfont}
\renewcommand{\cftfigfont}{\fontfamily{phv}\fontsize{11}{11}\selectfont}
\renewcommand{\cftchappagefont}{\fontfamily{phv}\fontsize{12}{13}\selectfont\bfseries}
\renewcommand{\cftsecpagefont}{\fontfamily{phv}\fontsize{11}{11}\selectfont}
\renewcommand{\cftsubsecpagefont}{\fontfamily{phv}\fontsize{11}{11}\selectfont}
\renewcommand{\cfttabpagefont}{\fontfamily{phv}\fontsize{11}{11}\selectfont}
\renewcommand{\cftfigpagefont}{\fontfamily{phv}\fontsize{11}{11}\selectfont}
\setlength{\cftsecindent}{10mm}
\setlength{\cftsubsecindent}{20mm}
%\setcounter{secnumdepth}{3} % uncomment to number subsubsections
%\setcounter{tocdepth}{3} % uncommand to show subsubsections in ToC


%% Remove extra space between items in bibliography, 8mm hanging indent
% 
\setlength{\bibsep}{0pt plus 0.3ex}
\setlength{\bibhang}{8mm}
% !!!!!!!!!!!!!!!!!!! \setcitestyle DOES NOT UNDERSTAND SPACES BETWEEN ARGUMENTS!!!!!!!!!!
% \setcitestyle{numbers,open={[},close={]}}                        % <------ Ugly numbers in squre brackets
\setcitestyle{authoryear,open={(},close={)},aysep={}}              % <------ Perfect (Name, Year) citation

%% Set font and size for captions in figures & tables
%
\DeclareCaptionFont{utu}{\fontfamily{phv}\fontsize{8.5}{11}\selectfont}
\DeclareCaptionLabelSeparator{utu}{.\rule{1ex}{0pt}}
\captionsetup{font=utu,labelfont=bf,justification=raggedright,singlelinecheck=false,labelsep=utu,tableposition=top,figureposition=below}

%% Use running counters on figures, tables and equations
%
\counterwithout{figure}{chapter}
\counterwithout{table}{chapter}
\counterwithout{equation}{chapter}

%% define 15% black for tables
%
\definecolor[named]{utugray}{rgb}{.85,.85,.85}

%% provide entry environment
%
\newenvironment{entry}[1]
{\begin{list}{}{%
      \renewcommand{\makelabel}[1]{\textrm{##1}\hfil}%
      \settowidth{\labelwidth}{\textrm{#1}}%
      \setlength{\leftmargin}{\labelwidth}%
      \setlength{\labelsep}{10mm}
      \addtolength{\leftmargin}{\labelsep}}}
{\end{list}}

%% provide infobox environment (here hidden out of plain sight...yikes!)
%
\newsavebox{\mybox}
\newenvironment{infobox}[1]
{\setlength{\orig}{\tabcolsep}\setlength{\fboxrule}{0.5pt}\setlength{\tabcolsep}{2pt}\begin{lrbox}{\mybox}\begin{tabular}{p{35mm}p{\dimexpr\textwidth-40mm\relax}}
   \raisebox{-\dimexpr\height-11pt\relax}{\includegraphics[width=35mm,height=50mm]{#1}}
    & 
    \begin{minipage}[t]{\dimexpr\textwidth-40mm\relax}
      \fontfamily{ptm}\fontsize{11}{12}\selectfont\mbox{\sffamily\MakeUppercase\Author}\\}
{\end{minipage}\end{tabular}\end{lrbox}\fbox{\usebox{\mybox}}\setlength{\tabcolsep}{\orig}\normalfont}

%% Stuff for including original articles
%

% a length to track location of the tab
\newlength{\boxskip}\setlength{\boxskip}{0mm}
% a counter for included articles
\newcounter{origpaperscnt}
% these booleans will control whether we have a numbered tab or a plain one
\newif\ifLabel
\newif\ifTab

% position and contents of the tabs; hooked into page shipout 
\newcommand{\AddTabs}{%
  \AddEverypageHook{%
    \ifTab%
    \ifodd\value{page} 
    \backgroundsetup{
      angle=0,
      position={145mm,-\dimexpr 22mm+\boxskip \relax},
      contents={%
        \tikz\node[minimum width=6mm, minimum height=29mm,fill=black]{ }; % <------------- was 35mm
      }%
    }
    \fi
    \BgMaterial%
    \else\relax\fi
    \ifLabel%
    \ifodd\value{page} %
    \backgroundsetup{
      angle=0,
      position={140mm,-\dimexpr 22mm+\boxskip\relax},
      contents={%
        \tikz\node[minimum width=16mm,minimum height=29mm,fill=black,  % <------------- was 35mm
        text=white]
        {\parbox[c]{16mm}{\centering\fontfamily{ptm}\fontsize{30}{30}\selectfont\textbf{\Roman{origpaperscnt}}}};
      }%
    }
    \fi
    \BgMaterial%
    \else\relax\fi}%
}
\newcommand\RemoveTabs{\Tabfalse\Labelfalse}

% insert info about publication, as well as:
% - turn on numbered tab
% - move tab accordingly
% - advance publication counter
%
% parameters:
% #1 Author, #2 Title(s), #3 Publishing info
%
\newcommand{\origpub}[3]{
  \Tabfalse\Labeltrue
  \addtolength{\boxskip}{29mm}  % <------------- was 35mm
  \stepcounter{origpaperscnt}
  % lets try to keep info beside the numbered tab in the margin
  \ifnum\value{origpaperscnt} > 1
  \vspace*{\dimexpr\boxskip-4mm\relax} % <------------- -6mm
  \else
  % This controls the title of the first paper and for some reason is always offset
  \vspace*{\dimexpr\boxskip-35mm\relax} % <------------- -6mm 
  \fi
  \begin{flushright}
    \fontfamily{phv}\fontsize{13}{15}\bfseries\selectfont
    #1\\
    #2\\[2mm]
    \fontfamily{phv}\fontsize{11}{14}\mdseries\selectfont
    #3
  \end{flushright}
  \clearpage
}

% insert a publication, we'll use tikz and include the file one page at
% a time in a loop since \includepdf from pdfpages doesn't seem to
% center properly with our page layout for some reason.
%
% parameters:
% #1 document filename, #2 number of pages
%
\newcounter{myint}
\newcommand{\insertpub}[2]{
  \Labelfalse\Tabtrue
  \setcounter{myint}{0}
  \loop
  \stepcounter{myint}
  \begin{tikzpicture}[remember picture,overlay]
    \node[minimum width=150mm, minimum height=220mm] at (current page.center)
    {\resizebox{150mm}{!}{\includegraphics[page=\themyint]{#1}}};
  \end{tikzpicture}
  \clearpage
  \ifnum \value{myint}<#2
  \repeat
  \cleardoublepage
}

%% some extra commands follow
%

% do stuff based on language
\newif\iffin


% image on the coverpage?
\newif\ifimgcover
\newcommand{\coverinfo}[1]{
  \newsavebox{\cvrbox}\sbox{\cvrbox}{\fontfamily{phv}\fontsize{10}{12}\mdseries\selectfont
    #1}
}

% commands to collect various data about the work
\makeatletter
\newcommand{\@authorx}{?}
\newcommand{\authorx}[1]{\renewcommand{\@authorx}{#1}}
\newcommand{\@subtitle}{?}
\newcommand{\subtitle}[1]{\renewcommand{\@subtitle}{#1}}
\newcommand{\@isbnprint}{?}
\newcommand{\isbnprint}[1]{\renewcommand{\@isbnprint}{#1}}
\newcommand{\@isbnweb}{?}
\newcommand{\isbnweb}[1]{\renewcommand{\@isbnweb}{#1}}
\newcommand{\@issnprint}{?}
\newcommand{\issnprint}[1]{\renewcommand{\@issnprint}{#1}}
\newcommand{\@issnweb}{?}
\newcommand{\issnweb}[1]{\renewcommand{\@issnweb}{#1}}
\newcommand{\@printedat}{?}
\newcommand{\printedat}[1]{\renewcommand{\@printedat}{#1}}
\makeatother

% other commands to save some data for later use. We need many boxes
% since the different font sizes specified for various locations where
% these are to be used...
\newcommand{\faculty}[2]{%
  \newsavebox{\facen}\sbox{\facen}{\fontfamily{phv}\fontsize{10}{12}\mdseries\selectfont
    #1}
  \newsavebox{\facaen}\sbox{\facaen}{\fontfamily{phv}\fontsize{11}{13}\mdseries\selectfont
    #1}
  \newsavebox{\facfi}\sbox{\facfi}{\fontfamily{phv}\fontsize{10}{12}\mdseries\selectfont
    #2}
  \newsavebox{\facafi}\sbox{\facafi}{\fontfamily{phv}\fontsize{11}{13}\mdseries\selectfont
    #2} }
\newcommand{\dept}[2]{%
  \newsavebox{\dpten}\sbox{\dpten}{\fontfamily{phv}\fontsize{10}{12}\mdseries\selectfont
    #1}
  \newsavebox{\dptaen}\sbox{\dptaen}{\fontfamily{phv}\fontsize{11}{13}\mdseries\selectfont
    #1}
  \newsavebox{\dptfi}\sbox{\dptfi}{\fontfamily{phv}\fontsize{10}{12}\mdseries\selectfont
    #2}
  \newsavebox{\dptafi}\sbox{\dptafi}{\fontfamily{phv}\fontsize{11}{13}\mdseries\selectfont
    #2} }
\newcommand{\subject}[2]{%
  \newsavebox{\suben}\sbox{\suben}{\fontfamily{phv}\fontsize{10}{12}\mdseries\selectfont
    #1}
  \newsavebox{\subaen}\sbox{\subaen}{\fontfamily{phv}\fontsize{11}{13}\mdseries\selectfont #1}
  \newsavebox{\subfi}\sbox{\subfi}{\fontfamily{phv}\fontsize{10}{12}\mdseries\selectfont
    #2}
  \newsavebox{\subafi}\sbox{\subafi}{\fontfamily{phv}\fontsize{11}{13}\mdseries\selectfont
    #2}
}
\newcommand{\programme}[2]{%
  \newsavebox{\prgen}\sbox{\prgen}{\fontfamily{phv}\fontsize{10}{12}\mdseries\selectfont
    #1}
  \newsavebox{\prgaen}\sbox{\prgaen}{\fontfamily{phv}\fontsize{11}{13}\mdseries\selectfont #1}
  \newsavebox{\prgfi}\sbox{\prgfi}{\fontfamily{phv}\fontsize{10}{12}\mdseries\selectfont
    #2}
  \newsavebox{\prgafi}\sbox{\prgafi}{\fontfamily{phv}\fontsize{11}{13}\mdseries\selectfont
    #2}
}
\newcommand{\mnth}[2]{%
  \newsavebox{\mnthaen}\sbox{\mnthaen}{\fontfamily{phv}\fontsize{11}{13}\mdseries\selectfont
    #1}
  \newsavebox{\mnthafi}\sbox{\mnthafi}{\fontfamily{phv}\fontsize{11}{13}\mdseries\selectfont
    #2}
}

%% Generate title page
%
\newcommand{\TitlePage}[1]{%
  \thispagestyle{empty}
  \begin{center}
    \mbox{}\\[-32pt]
    \iffin
    \resizebox{55mm}{!}{\includegraphics{logos/UTU_logo_FI_RGB.png}}
    \else
    \resizebox{55mm}{!}{\includegraphics{logos/UTU_logo_EN_RGB.png}}
    \fi
  \end{center}
  % \vspace*{140pt}
  \vfill
  \parbox[c]{\textwidth}{
    \begin{center}
      \fontfamily{phv}\fontsize{24}{24}\bfseries\selectfont
      \MakeUppercase{\Title}\\[\baselineskip]
      \fontfamily{phv}\fontsize{16}{16}\mdseries\selectfont
      \Stitle\\
      \rule{\textwidth}{4pt}\\[.5\baselineskip]
      \Author
    \end{center}
  }
  % \vspace*{\fill}
  \vfill
  \begin{tikzpicture}[remember picture,overlay]
    \node[anchor=south west,minimum width=176mm,minimum
    height=34mm,fill=black!75,text=white] (RB) at (current page.south
    west){\fontsize{9}{11}\bfseries\selectfont\parbox[c]{166mm}{\centering
        TURUN YLIOPISTON JULKAISUJA -- ANNALES UNIVERSITATIS
        TURKUENSIS\\\MakeUppercase{#1}
      }};
  \end{tikzpicture}
  \normalfont
  \newpage
}

\newcommand{\Leaflet}[3]{%
  \thispagestyle{empty}
  \begin{center}
    \mbox{}\\[-32pt]
    \iffin
    \resizebox{55mm}{!}{\includegraphics{logos/UTU_logo_FI_RGB.png}}
    \else
    \resizebox{55mm}{!}{\includegraphics{logos/UTU_logo_EN_RGB.png}}
    \fi
  \end{center}
  % \vspace*{140pt}
  \vfill
  \parbox[c]{\textwidth}{
    \begin{center}
      \fontfamily{phv}\fontsize{24}{24}\bfseries\selectfont
      \MakeUppercase{\Title}\\[\baselineskip]
      \fontfamily{phv}\fontsize{16}{16}\mdseries\selectfont
      \Stitle\\
      \rule{\textwidth}{4pt}\\[.5\baselineskip]
      \Author
    \end{center}
  }
  % \vspace*{\fill}
  %\vfill
  \vspace{0.25cm}
  \begin{center}
    \parbox[t]{\textwidth}{
      \fontfamily{phv}\fontsize{14}{16}\bfseries\selectfont
      \centering
      \iffin AKATEEMINEN VÄITÖSKIRJA \else ACADEMIC
        DISSERTATION \fi\\[\baselineskip]
    }
  \end{center}
  \begin{tikzpicture}[remember picture, overlay]
    \node[anchor=west] at (-2, -1)  {\parbox[c]{0.95\textwidth}{
      \raggedleft\fontfamily{phv}\fontsize{12}{14}\mdseries\selectfont
          #2 
        }};
    \node[anchor=west] at (11, -1) {\includegraphics[keepaspectratio, width = 0.25\textwidth]{#3}};
  \end{tikzpicture}
  \vfill
  \begin{tikzpicture}[remember picture,overlay]
    \node[anchor=south west,minimum width=176mm,minimum
    height=34mm,fill=black!75,text=white] (RB) at (current page.south
    west){\fontsize{9}{11}\bfseries\selectfont\parbox[c]{166mm}{\centering
        TURUN YLIOPISTON JULKAISUJA -- ANNALES UNIVERSITATIS
        TURKUENSIS\\\MakeUppercase{#1}
      }};
  \end{tikzpicture}
  \normalfont
  \newpage
}

%% Generate backside of title page
%
  \newcommand{\TitleBack}[6]{%
  \thispagestyle{empty}
  \setlength{\orig}{\tabcolsep}
  \setlength{\tabcolsep}{.8ex}

  % 1st block, faculty, department, etc.
  \fontfamily{phv}\fontsize{12}{16}\bfseries\selectfont
  \noindent
  \iffin Turun yliopisto \else University of Turku \fi\\[-.3\baselineskip]
  \rule{60mm}{.5pt}\\[.3\baselineskip]
  \fontsize{10}{12}\mdseries\selectfont
  \rule{-2mm}{0pt}
  \begin{tabular}{p{\textwidth}}
    \iffin
    \usebox{\facfi}\\
    \usebox{\dptfi}\\
    \usebox{\subfi}\\
    \usebox{\prgfi}\\
    \else
    \usebox{\facen}\\
    \usebox{\dpten}\\
    \usebox{\suben}\\
    \usebox{\prgen}\\
    \fi
  \end{tabular}\\[10mm]

  % 2nd block, supervisor(s)
  \fontfamily{phv}\fontsize{12}{16}\bfseries\selectfont
  \noindent
  \iffin Ohjaajat \else Supervised by \fi\\[-.3\baselineskip]
  \rule{60mm}{.5pt}\\[.3\baselineskip]
  \fontsize{10}{12}\mdseries\selectfont
  \rule{-2mm}{0pt}
  \begin{tabular}{p{.5\textwidth}p{.5\textwidth}}
    \parbox[t]{.48\textwidth}{#1}&
    \parbox[t]{.48\textwidth}{#2}\\\\
    \parbox[t]{.48\textwidth}{#3}
  \end{tabular}\\[10mm]

  % 3rd block, reviewer(s)
  \fontfamily{phv}\fontsize{12}{16}\bfseries\selectfont
  \noindent
  \iffin Tarkastajat \else Reviewed by \fi\\[-.3\baselineskip]
  \rule{60mm}{.5pt}\\[.3\baselineskip]
  \fontsize{10}{12}\mdseries\selectfont
  \rule{-2mm}{0pt}
  \begin{tabular}{p{.5\textwidth}p{.5\textwidth}}
    \parbox[t]{.48\textwidth}{#4}&
    \parbox[t]{.48\textwidth}{#5}\\
  \end{tabular}\\[10mm]

  % 4th block, opponent
  \fontfamily{phv}\fontsize{12}{16}\bfseries\selectfont
  \noindent
  \iffin Vastaväittäjä \else Opponent \fi\\[-.3\baselineskip]
  \rule{60mm}{.5pt}\\[.3\baselineskip]
  \fontsize{10}{12}\mdseries\selectfont
  \rule{-2mm}{0pt}
  \begin{tabular}{p{\textwidth}}
    #6\\
  \end{tabular}
  \vspace*{\fill}

  % 5th block, Turnitin blurb, ISBN, etc.
  \noindent \parbox[t]{\textwidth}{
    \iffin
    Turun yliopiston laatujärjestelmän mukaisesti tämän julkaisun
    alkuperäisyys on tarkastettu Turnitin OriginalityCheck-järjestelmällä.
    \else
    The originality of this publication has been checked in accordance with
    the University of Turku quality assurance system using the Turnitin
    OriginalityCheck service.
    \fi\\[1.5\baselineskip]
  \ifimgcover
  \iffin Kansikuva: \else Cover Image: \fi\usebox{\cvrbox}
  \fi
  \\[2\baselineskip]
  ISBN \Isbnprint\ (\iffin Painettu\else PRINT\fi)\\
  ISBN \Isbnweb\ (PDF)\\
  ISSN \Issnprint\ (\iffin Painettu\else PRINT\fi)\\
  ISSN \Issnweb\ (\iffin Sähköinen\else ONLINE\fi)\\
  \Printedat\\[.2\baselineskip]
  }
  \setlength{\tabcolsep}{\orig}
  \normalfont
  \newpage
}



\newenvironment{abstract}
{
  \thispagestyle{plain}
  \fontfamily{phv}\fontsize{11}{13}\selectfont
  \noindent
  \iffin TURUN YLIOPISTO \else UNIVERSITY OF TURKU\fi\\
  \iffin
  \usebox{\facafi}\\
  \usebox{\dptafi}\\
  \usebox{\subafi}\\
  \else
  \usebox{\facaen}\\
  \usebox{\dptaen}\\
  \usebox{\subaen}\\
  \fi
  \MakeUppercase{\Authorx}: \Title\\
  \iffin Väitöskirja\else Doctoral dissertation\fi, \pageref{TotPages} \iffin s. \else pp.\fi\\
  \iffin
  \usebox{\prgafi}\\
  \usebox{\mnthafi}
  \else
  \usebox{\prgaen}\\
  \usebox{\mnthaen}
  \fi\the\year\\[8mm]
  \iffin TIIVISTELMÄ \else ABSTRACT\fi\\[8mm]
  \fontfamily{ptm}\fontsize{11}{12}\selectfont
}
{
  \normalfont
  \newpage
}


