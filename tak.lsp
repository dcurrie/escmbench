;;; TAK -- A vanilla version of the TAKeuchi function.
 
(define (tak x y z)
  (if (not (< y x))
      z
      (tak (tak (- x 1) y z)
           (tak (- y 1) z x)
           (tak (- z 1) x y))))

(do ((i 0 (+ 1 i))) ((= i 10))
  (tak 18 12 6))

(tak 18 12 6)
