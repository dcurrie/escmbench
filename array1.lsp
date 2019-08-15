;;; ARRAY1 -- One of the Kernighan and Van Wyk benchmarks.

(define (create-x n)
  (define result (vector.alloc n))
  (do ((i 0 (+ i 1)))
      ((>= i n) result)
    (aset! result i i)))

(define (create-y x)
  (let* ((n (length x))
         (result (vector.alloc n)))
    (do ((i (- n 1) (- i 1)))
        ((< i 0) result)
      (aset! result i (aref x i)))))

(define (my-try n)
  (length (create-y (create-x n))))

(define (go n)
  (let loop ((repeat 10000)
             (result '()))
    (if (> repeat 0)
        (loop (- repeat 1) (my-try n))
        result)))

(print (go 100))
