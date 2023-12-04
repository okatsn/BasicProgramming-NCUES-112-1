\documentclass[12pt,a4paper]{article}

\usepackage[a4paper,text={20.0cm,25.2cm},centering]{geometry}

\usepackage{setspace}
% Set the line spacing factor
\setstretch{1.6} % Set the line spacing


% Weave with xelatex this template works in the environment of MyTeXLifeWithJulia of MyTeXLife:2023
\usepackage{xeCJK}
\setCJKmainfont{Noto Sans CJK TC} % Specify Noto Sans CJK as the main font


\usepackage{amssymb,amsmath}
\usepackage{bm}
\usepackage{graphicx}
\usepackage{microtype}
\usepackage{hyperref}
{{#:tex_deps}}
{{{ :tex_deps }}}
{{/:tex_deps}}
\setlength{\parindent}{0pt}
\setlength{\parskip}{1.2ex}

\hypersetup
       {   pdfauthor = { {{{:author}}} },
           pdftitle={ {{{:title}}} },
           colorlinks=TRUE,
           linkcolor=black,
           citecolor=blue,
           urlcolor=blue
       }

{{#:title}}
\title{ {{{ :title }}} }
{{/:title}}

{{#:author}}
\author{ {{{ :author }}} }
{{/:author}}

{{#:date}}
\date{ {{{ :date }}} }
{{/:date}}

{{ :highlight }}

\begin{document}

{{#:title}}\maketitle{{/:title}}

{{{ :body }}}

\end{document}