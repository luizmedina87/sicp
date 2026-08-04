#lang racket

;; Finds and executes all files in the tests folder ending in "-tests.rkt"
(define tests-dir
  (path-only (find-system-path 'run-file)))

(define test-files
  (filter (lambda (file)
            (string-suffix? (path->string file) "-tests.rkt"))
          (directory-list tests-dir)))

(for ([file test-files])
  (define file-path (build-path tests-dir file))
  (printf "\n==================================================\n")
  (printf " Running: ~a\n" (path->string file-path))
  (printf "==================================================\n")
  (dynamic-require file-path #f))