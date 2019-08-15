(define (stress-gc-mark len)
  (do ((cnt (+ -1 len) (+ -1 cnt))
       (lst '() (cons lst lst)))
    ((negative? cnt))))

(stress-gc-mark 999999)
