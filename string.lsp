;;; STRING -- One of the Kernighan and Van Wyk benchmarks.

(define s "abcdef")

;; eflisp alias works for utf8 strings:
(define (substring-utf s start end)
  (string.sub s (string.inc s 0 start) (string.inc s 0 end)))
;; optimization for ASCII saves about 30% of run time
(define (substring-ascii s start end)
  (string.sub s start end))

(define substring string.sub)

;; note that string.count also counts utf not ascii
;(define strlen string.count)
(define strlen length) ; ascii

(define (grow)
  (set! s (string "123" s "456" s "789"))
  (set! s (string
           (substring s (div0 (strlen s) 2) (string.count s))
           (substring s 0 (+ 1 (div0 (strlen s) 2)))))
  s)

(define (trial n)
  (do ((i 0 (+ i 1)))
      ((> (strlen s) n) (strlen s))
    (grow)))

(define (my-try n)
  (do ((i 0 (+ i 1)))
      ((>= i 10) (strlen s))
    (set! s "abcdef")
    (trial n)))

;; this size fails on stock lisp9 
;; so reduce for apples to apples
;;
;;(do ((i 0 (+ 1 i))) ((= i 10))
;;  (my-try 500000))

(do ((i 0 (+ 1 i))) ((= i 10))
  (my-try 250000))
