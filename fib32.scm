;;; FIB -- A classic benchmark, computes fib(30) inefficiently.

(define (fib n)
  (if (< n 2)
    n
    (+ (fib (- n 1))
       (fib (- n 2)))))


(define (fibs n m)
  (if (> n m)
    #t
    (begin
      (princ (fib n))
      (princ "\n")
      (fibs (+ n 1) m))))

(fibs 0 33)
