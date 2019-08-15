(letrec*
  ((tak (lambda (x y z)
     (if (not-longer x y)
         z
         (tak (tak (cdr x) y z)
              (tak (cdr y) z x)
              (tak (cdr z) x y)))))
   (not-longer (lambda (a b)
     (if (eq a '())
         #t
         (if (eq b '())
             #f
             (not-longer (cdr a) (cdr b)))))))
  (tak '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18)
       '(1 2 3 4 5 6 7 8 9 10 11 12)
       '(1 2 3 4 5 6)))
