#lang racket/base
(require scribble/core
         scribble/base
         scribble/decode
         scribble/latex-properties
         scriblib/bibtex
         racket/list)
(require (for-syntax racket/base syntax/parse))
(provide chapter part chapter-ref part-ref ~cite citet gen-bib chapterquote)

(define chapter-ref secref)
(define Chapter-ref Secref)
(define part-ref secref)
(define Part-ref Secref)

(define (part #:tag [tag (symbol->string (gensym))]
              #:preamble [pre #f]
              . str)
  (define sec
    (apply section #:tag tag #:style (make-style #f '(grouper)) str))
  (if pre
      ;; The ctparttext has to come *before* the actual part command. Also it
      ;; has to be in its own part so that it's not ignored by the decode pass.
      (list (make-part
             #f null #f (make-style #f null) null
             (list (make-paragraph
                    (make-style #f null)
                    (make-element (make-style "ctparttext" null) pre)))
             null)
            sec)
      sec))

(define chapter section)

(define-syntax-rule (define-pre-title-wrappers (name style) ...)
  (begin
    (define (name . str)
      (make-paragraph
       (make-style 'pretitle '())
       (make-multiarg-element
        (make-style style '())
        (decode-content str))))
    ...
    (provide name ...)))

(define-syntax-rule (define-wrappers (name style) ...)
  (begin
    (define (name . str)
      (make-element (make-style style '()) (decode-content str)))
    ...
    (provide name ...)))

(define-syntax-rule (define-includer name style)
  (begin
    (define-syntax (name stx)
      (syntax-case stx ()
        [(_ module)
         (let ()
           (define name* (gensym 'name))
           #'(begin
               (require (rename-in module [doc name*]))
               (make-nested-flow (make-style style '(command))
                                 (part-blocks name*))))]))
    (provide name)))

(define-pre-title-wrappers
  (advisor "advisor")
  (degree "degreename")
  (field "field")
  (degreeyear "degreeyear")
  (degreemonth "degreemonth")
  (department "department")
  (pdOneName "pdOneName")
  (pdOneSchool "pdOneSchool")
  (pdOneYear "pdOneYear")
  (pdTwoName "pdTwoName")
  (pdTwoSchool "pdTwoSchool")
  (pdTwoYear "pdTwoYear"))

(define-wrappers
  (copyrightpage "copyrightpage")
  (tableofcontents "tableofcontents")
  (listoffigures "listoffigures")
  (doublespacing "doublespacing")
  (clearpage "clearpage")
  (setstretch "setstretch")
  (bibliographystyle "bibliographystyle")
  (todo "todo"))

(define-includer include-abstract "abstractpage")
(define-includer include-dedication "dedicationpage")
(define-includer include-acknowledgments "acknowledgments")


(define-bibtex-cite "bib.bib" ~cite citet gen-bib)

(define (chapterquote #:width [width "20em"] #:author [author #f] text)
  (make-paragraph
   (make-style 'pretitle '())
   (make-element
    (make-style "topquote"                
                (list (make-command-extras (list width))))
    (if author
        (list (make-element (make-style #f '()) text)
              (make-element (make-style "qauthor" '()) author))
        (make-element (make-style #f '()) text)))))
