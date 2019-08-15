;;; CAT -- One of the Kernighan and Van Wyk benchmarks.

(define inport #f)
(define outport #f)

(define (catport port)
  (let ((x (read-char port)))
    (if (eof-object? x)
        (close-output-port outport)
        (begin
          (write-char x outport)
          (catport port)))))

(define (go)
  (set! inport (open-input-file "testfile.in"))
  (set! outport (open-output-file "testfile.out"))
  (catport inport)
  (close-input-port inport))

(do ((i 0 (+ 1 i))) ((= 10 i)) (go))
