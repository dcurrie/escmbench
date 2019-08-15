# escmbench

Some simple benchmarks for tiny lisp or scheme interpreters.

## Why?

It's just for fun. There are many small scheme or lisp interpreters in the world, 
and it can be interesting to compare them to one another: size, features, performance, etc. 
This project is one attempt at it.

## What?

It started with the October 2018 version of the Scheme 9 from Empty Space (S9fES) benchmarks by Nils M Holm. 
Those benchmarks are geared toward mature scheme systems: S9fES (both old and Reimagined versions), Chicken, 
and MIT Scheme. See https://t3x.org/s9fes-reimagined/benchmarks.html

The goal for this project is to compare smaller scheme or lisp interpreters. For the first version, this 
includes: 
* [LISP9](https://www.t3x.org/lisp9/index.html)
* [tiny](https://github.com/JeffBezanson/femtolisp) `femtolisp/tiny/lisp.c`
* [femtolisp](https://github.com/JeffBezanson/femtolisp)
* [eflisp](https://chiselapp.com/user/e/repository/eflisp) my own customized femtolisp

## Using

After placing the executables and support files in the `escmbench` directory, run with

```
sh bench.sh
```

The executables and support files are:

* eflisp
* flisp
  * flisp.boot
* tiny
  * system.lsp
* ls9
  * ls9.image

Build each according to its own default build instructions.

Note that `eflisp` has its support files integrated into the executable.

Note: I modified `femtolisp/tiny/lisp.c` to fix a clang warning on macOS:

```
diff --git a/tiny/lisp.c b/tiny/lisp.c
index 4b9ffbc..ce417a4 100644
--- a/tiny/lisp.c
+++ b/tiny/lisp.c
@@ -501,7 +501,7 @@ void print(FILE *f, value_t v)
     value_t cd;
 
     switch (tag(v)) {
-    case TAG_NUM: fprintf(f, "%ld", numval(v)); break;
+    case TAG_NUM: fprintf(f, "%lld", numval(v)); break;
     case TAG_SYM: fprintf(f, "%s", ((symbol_t*)ptr(v))->name); break;
     case TAG_BUILTIN: fprintf(f, "#<builtin %s>",
                               builtin_names[intval(v)]); break;
```

## Timing Results

With versions:

* femtolisp JeffBezanson/femtolisp@ec7601076a976f845bc05ad6bd3ed5b8cde58a97 June 6, 2019
* tiny (femtolisp/tiny/lisp.c) from the same femtolisp version
* efisp 2019-08-03T02:15:04 [e014ef2a33]
* LISP9 20190812

I learned that generally the times are, eflisp < flisp < ls9 < tiny

Except for `ctak` and `string`, `ls9` is two to four times `flisp` execution time. 
Looking for the culprit(s), I dumped some disassemblies; see `grok_eflisp_v_lisp9.txt`.
It appears that `ls9` instruction count is about 3x that of `eflisp`. 
Perhaps `ls9` would benefit from a peephole optimizer.

Example output on MacBook Pro (2018; 2.9 GHz Intel Core i9; 32 GB 2400 MHz DDR4):

```
escmbench e% sh bench.sh        
(times   ls9 flisp eflisp tiny )
(blank  0.00  0.01  0.00  0.00 )
(ack    0.40  0.07  0.06  0.27 )
(array  0.28  0.08  0.07  x.xx )
(boyer  1.03  0.28  0.10  4.23 )
(ctak   0.02  0.09  0.07  x.xx )
(cptak  0.14  0.03  0.03  0.16 )
(fib    0.33  0.06  0.06  0.20 )
(ltak   0.05  0.02  0.01  0.07 )
(strng  0.12  0.15  0.13  x.xx )
(tak    0.09  0.02  0.01  0.09 )
escmbench e% sh bench.sh
(times   ls9 flisp eflisp tiny )
(blank  0.01  0.01  0.00  0.00 )
(ack    0.43  0.07  0.06  0.27 )
(array  0.30  0.08  0.08  x.xx )
(boyer  1.14  0.30  0.11  4.42 )
(ctak   0.02  0.09  0.07  x.xx )
(cptak  0.14  0.03  0.03  0.16 )
(fib    0.34  0.06  0.06  0.22 )
(ltak   0.05  0.02  0.01  0.07 )
(strng  0.12  0.17  0.12  x.xx )
(tak    0.10  0.02  0.01  0.10 )
escmbench e% sh bench.sh          
(times   ls9 flisp eflisp tiny )
(blank  0.00  0.03  0.00  0.00 )
(ack    0.40  0.07  0.06  0.27 )
(array  0.28  0.08  0.07  x.xx )
(boyer  1.06  0.29  0.10  4.35 )
(ctak   0.02  0.08  0.07  x.xx )
(cptak  0.14  0.05  0.03  0.16 )
(fib    0.33  0.06  0.06  0.21 )
(ltak   0.05  0.02  0.01  0.07 )
(strng  0.13  0.17  0.13  x.xx )
(tak    0.09  0.02  0.01  0.09 )
escmbench e% sh bench.sh
(times   ls9 flisp eflisp tiny )
(blank  0.00  0.01  0.00  0.00 )
(ack    0.42  0.07  0.06  0.27 )
(array  0.31  0.08  0.07  x.xx )
(boyer  1.07  0.29  0.10  4.40 )
(ctak   0.02  0.09  0.07  x.xx )
(cptak  0.14  0.03  0.03  0.16 )
(fib    0.34  0.07  0.06  0.22 )
(ltak   0.05  0.01  0.01  0.07 )
(strng  0.12  0.16  0.13  x.xx )
(tak    0.09  0.02  0.01  0.09 )
escmbench e% sh bench.sh 
(times   ls9 flisp eflisp tiny )
(blank  0.01  0.01  0.00  0.00 )
(ack    0.42  0.07  0.06  0.27 )
(array  0.30  0.08  0.07  x.xx )
(boyer  1.08  0.29  0.11  4.39 )
(ctak   0.02  0.09  0.08  x.xx )
(cptak  0.15  0.03  0.03  0.16 )
(fib    0.33  0.06  0.06  0.21 )
(ltak   0.05  0.02  0.01  0.07 )
(strng  0.12  0.19  0.13  x.xx )
(tak    0.09  0.02  0.01  0.10 )
escmbench e% sh bench.sh
(times   ls9 flisp eflisp tiny )
(blank  0.00  0.01  0.00  0.00 )
(ack    0.41  0.07  0.06  0.27 )
(array  0.29  0.08  0.07  x.xx )
(boyer  1.06  0.29  0.10  4.45 )
(ctak   0.02  0.10  0.08  x.xx )
(cptak  0.15  0.03  0.03  0.17 )
(fib    0.34  0.06  0.06  0.22 )
(ltak   0.05  0.02  0.01  0.07 )
(strng  0.13  0.16  0.15  x.xx )
(tak    0.10  0.02  0.01  0.10 )
escmbench e% 
```

## Size Results

The static (on disk) sizes of `eflisp` `flisp` and `ls9` are all similar, except that the 
support file `ls9.image` is huge because it is the entire heap rather than just the active and
compacted portion. The on-disk size of `tiny` is consistent with its name.

Process memory measurements were obtained with the Mac's Activity Monitor after running the 
Boyer benchmark to exercise the garbage collectors. The three femtolisp based lisps use a 
two-space memory model, so it's not surprising that their runtime memory use is higher than
LISP9, though they're not quite twice as big.

Name | Executable | Support file | TEXT seg | DATA seg | Process Memory
---- | ---------- | ------------ | -------- | -------- | --------------
tiny   |    27360 |        13340 |    20480 |   397312 |  4.7 MB
eflisp |   272152 |            0 |   200704 |    16384 |  5.1 MB
flisp  |   188764 |        39820 |   151552 |    20480 |  6.1 MB
ls9    |   210100 |      3407956 |   159744 |     4096 |  3.6 MB

Raw data:

```
escmbench e% size ./tiny
__TEXT  __DATA  __OBJC  others  dec hex
20480   397312  0   4294971392  4295389184  100067000
escmbench e% ls -l tiny 
-rwxr-xr-x  1 e  staff  27360 Aug 12 15:11 tiny
escmbench e% ls -l system.lsp 
-rw-r--r--  1 e  staff  13340 Aug 14 17:57 system.lsp

escmbench e% size ./eflisp
__TEXT  __DATA  __OBJC  others  dec hex
200704  16384   0   4295032832  4295249920  100045000   
escmbench e% ls -l eflisp
-rwxr-xr-x  1 e  staff  272152 Aug 15 15:41 eflisp

escmbench e% size ./flisp
__TEXT  __DATA  __OBJC  others  dec hex
151552  20480   0   4295000064  4295172096  100032000
escmbench e% ls -l flisp
-rwxr-xr-x  1 e  staff  188764 Aug 14 16:10 flisp
escmbench e% ls -l flisp.boot 
-rw-r--r--  1 e  staff  39820 Aug 11 20:47 flisp.boot

escmbench e% size ./ls9  
__TEXT  __DATA  __OBJC  others  dec hex
159744  4096    0   4295016448  4295180288  100034000
escmbench e% ls -l ls9
-rwxr-xr-x  1 e  staff  210100 Aug 14 20:51 ls9
escmbench e% ls -l ls9.image 
-rw-r--r--  1 e  staff  3407956 Aug 14 20:51 ls9.image

```
