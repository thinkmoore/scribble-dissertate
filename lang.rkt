#lang racket/base
(require scribble/doclang
         (rename-in scribble/core [part sc:part])
         (except-in scribble/base table-of-contents)
         scribble/private/defaults
         scriblib/figure
         racket/list
         racket/include
         setup/collects
         "main.rkt"
         (for-syntax racket/base))
(provide (except-out (all-from-out scribble/doclang) #%module-begin)
         (all-from-out "main.rkt")
         (all-from-out racket/include)
         (all-from-out scribble/base)
         (all-from-out scriblib/figure)
         (rename-out [module-begin #%module-begin]))

(define-syntax (module-begin stx)
  (syntax-case stx ()
    [(_ id . body)
     #`(#%module-begin id post-process () . body)]))

(define (post-process doc)
  (add-defaults doc
                (string->bytes/utf-8 "\\documentclass{Dissertate}\n")
                (path->collects-relative (collection-file-path "style.tex" "dissertate"))
                (list
                 (path->collects-relative (collection-file-path "Dissertate.cls" "dissertate")))
                #f))
