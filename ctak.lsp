;;; CTAK -- A version of the TAK procedure that uses continuations.

;; --  call/cc hack to make this test run
;;
;(define (call-with-current-continuation fun)
;  (let* ((tag (list 'tag))
;         (res #f))
;    (trycatch (set! res (fun (lambda (r) (set! res r) (raise tag))))
;      (lambda (e) (if (eq? e tag) #t (raise e))))
;    res))

(define (call-with-current-continuation fun)
  (let ((tag (cons 'tag '())))
    (trycatch (fun (lambda (r) (raise (cons tag r))))
      (lambda (e) (if (and (pair? e) (eq? (car e) tag)) (cdr e) (raise e))))))

;(define (ctak x y z)
;  (call-with-current-continuation
;   (lambda (k) (ctak-aux k x y z))))
;
;(define (ctak-aux k x y z)
;  (if (not (< y x))
;      (k z)
;      (call-with-current-continuation
;       (lambda (k)
;         (ctak-aux
;          k
;          (call-with-current-continuation
;           (lambda (k) (ctak-aux k (- x 1) y z)))
;          (call-with-current-continuation
;           (lambda (k) (ctak-aux k (- y 1) z x)))
;          (call-with-current-continuation
;           (lambda (k) (ctak-aux k (- z 1) x y))))))))

(define (ctak x y z)
  (define (ctak-aux k x y z)
    (if (not (< y x))
        (k z)
        (call-with-current-continuation
         (lambda (k)
           (ctak-aux
            k
            (call-with-current-continuation
             (lambda (k) (ctak-aux k (- x 1) y z)))
            (call-with-current-continuation
             (lambda (k) (ctak-aux k (- y 1) z x)))
            (call-with-current-continuation
             (lambda (k) (ctak-aux k (- z 1) x y))))))))
  (call-with-current-continuation
   (lambda (k) (ctak-aux k x y z))))

(ctak 18 12 6)
