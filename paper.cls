\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{paper}

\newif\ifacm
\newif\ifdraft
\newif\ifarxiv
\newif\ifspace
\newif\ifapx

\DeclareOption{arxiv}{
    \draftfalse
    \arxivtrue
}

\DeclareOption{workingdraft}{
    \drafttrue
    \arxivfalse
}

\DeclareOption{final}{
    \draftfalse
    \arxivfalse
}

\DeclareOption{acm}{\acmtrue}
\DeclareOption{space}{\spacetrue}

\DeclareOption*{
    \ifacm\PassOptionsToClass{\CurrentOption}{acmart}\else
    \PassOptionsToClass{\CurrentOption}{article}
    \fi
}

\ProcessOptions

\ifacm
\LoadClass[sigconf]{acmart}
\renewcommand\footnotetextcopyrightpermission[1]{}
\settopmatter{printfolios=true, printacmref=false}
\else
\LoadClass[letterpaper,twocolumn,10pt]{article}
\RequirePackage{usenix-2020-09}
\fi

\frenchspacing

\bibliographystyle{abbrv}

\ifacm
\else
\RequirePackage{authblk}
\fi

\RequirePackage{xspace}
\RequirePackage{graphicx}
\RequirePackage{subcaption}
\RequirePackage{enumitem}
\RequirePackage[framemethod=tikz]{mdframed}
\mdfdefinestyle{protocol}{,,roundcorner=10pt,}
\RequirePackage{algorithm}
\RequirePackage[noend]{algpseudocode}
\RequirePackage{braket}
\RequirePackage{tikz}
\RequirePackage{amsthm}
\RequirePackage{comment}
\ifacm
\else
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\fi


\hypersetup{linkcolor=blue}

\theoremstyle{definition}
\newtheorem{invariant}{Invariant}

\ifacm
\else
\newtheorem{theorem}{Theorem}[section]
\newtheorem{lemma}[theorem]{Lemma}
\fi
\newtheorem{principle}{Principle}

\def\Snospace~{\S{}}
% Autoref
\def\chapterautorefname{Chapter}
\def\sectionautorefname{\Snospace}
\def\subsectionautorefname{\Snospace}
\def\subsubsectionautorefname{\Snospace}
\def\appendixautorefname{Appendix}
\def\thmautorefname{Theorem}
\def\lemautorefname{Lemma}
\def\defnautorefname{Definition}
\def\algorithmautorefname{Algorithm}
\def\invariantautorefname{Invariant}
\def\principleautorefname{Principle}

\algnewcommand\algorithmicswitch{\textbf{switch}}
\algnewcommand\algorithmiccase{\textbf{case}}
\algdef{SE}[SWITCH]{Switch}{EndSwitch}[1]{\algorithmicswitch\ #1\ \algorithmicdo}{\algorithmicend\ \algorithmicswitch}
\algdef{SE}[CASE]{Case}{EndCase}[1]{\algorithmiccase\ #1}{\algorithmicend\ \algorithmiccase}
\algtext*{EndSwitch}
\algtext*{EndCase}

\usetikzlibrary{shapes.geometric, arrows, matrix}

\IfFileExists{macros.tex}{\input{macros}}{}