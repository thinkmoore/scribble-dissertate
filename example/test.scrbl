#lang dissertate

@title{A dissertation on a topic}
@author{J. Student}
@advisor{A. Professor}

@degree{Doctor of Philosophy}
@field{Underwater Basket Weaving}
@degreeyear{2016}
@degreemonth{May}
@department{Under the Sea}

@pdOneName{B.S.}
@pdOneSchool{In the ocean}
@pdOneYear{2007}

@pdTwoName{M.S.}
@pdTwoSchool{In the ocean}
@pdTwoYear{2008}

@copyrightpage{}

@; Must have empty line above to avoid an empty page
@include-abstract{frontmatter/abstract.scrbl}
@tableofcontents{}
@listoffigures{}

@; Must have empty line above to avoid an empty page
@include-dedication{frontmatter/dedication.scrbl}

@; Must have empty line above to avoid an empty page
@include-acknowledgments{frontmatter/acknowledgments.scrbl}

@doublespacing{}

@chapter{Introduction}
@chapter{More Stuff}
@part{A DIVIDER!}
@chapter{The Rest}

@cite{Nobody06}

@clearpage{}
@gen-bib{}
@bibliographystyle{apalike2}

@include-section{endmatter/colophon.scrbl}
