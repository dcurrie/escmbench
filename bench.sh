#!/bin/sh

# e based on run.sh on s9fes scmbench

# see https://www.shellscript.sh/echo.html

if [ "`echo -n`" = "-n" ]; then
  n=""
  c="\c"
else
  n="-n"
  c=""
fi

run_l9() {
    /usr/bin/time ./ls9 <$1
}

run_ef() {
    /usr/bin/time ./eflisp <$1
}

run_fl() {
    /usr/bin/time ./flisp <$1
}

run_ty() {
    /usr/bin/time ./tiny <$1
}

print_time() {
    echo $n " $(sed -e 's/ *\([0-9\.]*\) real.*/\1/g' <times)" $c
}

echo "(times   ls9 flisp eflisp tiny )"

echo $n "(blank" $c
run_l9 blank.scm 2>times >/dev/null; print_time
run_fl blank.scm 2>times >/dev/null; print_time
run_ef blank.scm 2>times >/dev/null; print_time
run_ty blank.scm 2>times >/dev/null; print_time
echo ")"

echo $n "(ack  " $c
run_l9 ack.ls9 2>times >/dev/null; print_time
run_fl ack.scm 2>times >/dev/null; print_time
run_ef ack.scm 2>times >/dev/null; print_time
run_ty ack.tny 2>times >/dev/null; print_time
echo ")"

echo $n "(array" $c
run_l9 array.ls9 2>times >/dev/null; print_time
run_fl array1.lsp 2>times >/dev/null; print_time
run_ef array1.lsp 2>times >/dev/null; print_time
echo $n " x.xx" $c
echo ")"

echo $n "(boyer" $c
run_l9 boyer.ls9 2>times >/dev/null; print_time
run_fl boyer.lsp 2>times >/dev/null; print_time
run_ef boyer.lsp 2>times >/dev/null; print_time
run_ty boyer.tny 2>times >/dev/null; print_time
echo ")"

echo $n "(ctak " $c
run_l9 ctak.ls9 2>times >/dev/null; print_time
run_fl ctak.lsp 2>times >/dev/null; print_time
run_ef ctak.lsp 2>times >/dev/null; print_time
echo $n " x.xx" $c
echo ")"

echo $n "(cptak" $c
run_l9 cpstak.ls9 2>times >/dev/null; print_time
run_fl cpstak.scm 2>times >/dev/null; print_time
run_ef cpstak.scm 2>times >/dev/null; print_time
run_ty cpstak.tny 2>times >/dev/null; print_time
echo ")"

echo $n "(fib  " $c
run_l9 fib.ls9 2>times >/dev/null; print_time
run_fl fib.scm 2>times >/dev/null; print_time
run_ef fib.scm 2>times >/dev/null; print_time
run_ty fib.scm 2>times >/dev/null; print_time
echo ")"

echo $n "(ltak " $c
run_l9 ltak.ls9 2>times >/dev/null; print_time
run_fl ltak.fls 2>times >/dev/null; print_time
run_ef ltak.lsp 2>times >/dev/null; print_time
run_ty ltak.tny 2>times >/dev/null; print_time
echo ")"

echo $n "(strng" $c
run_l9 string.ls9 2>times >/dev/null; print_time
run_fl string.lsp 2>times >/dev/null; print_time
run_ef string.lsp 2>times >/dev/null; print_time
echo $n " x.xx" $c
echo ")"

echo $n "(tak  " $c
run_l9 tak.ls9 2>times >/dev/null; print_time
run_fl tak.lsp 2>times >/dev/null; print_time
run_ef tak.lsp 2>times >/dev/null; print_time
run_ty tak.tny 2>times >/dev/null; print_time
echo ")"
