#lang racket/base
(require scribble/doclang
         scribble/core
         scribble/base
         scribble/sigplan
         scribble/latex-properties
         racket/list
         setup/collects
         "main.rkt"
         (for-syntax racket/base))
(provide (except-out (all-from-out scribble/doclang) #%module-begin)
         (all-from-out "main.rkt")
         (all-from-out scribble/base)
         (rename-out [module-begin #%module-begin]))

(define-syntax (module-begin stx)
  (syntax-case stx ()
    [(_ id . body)
     #`(#%module-begin id post-process () . body)]))

(define (post-process doc)
  (struct-copy part doc
               [style (make-style
                       (style-name (part-style doc))
                       (list (make-latex-defaults
                              (string->bytes/utf-8 "\\documentclass{Dissertate}\n")
                              (path->collects-relative (collection-file-path "Dissertate.cls" "dissertate"))
                              empty)))]))
