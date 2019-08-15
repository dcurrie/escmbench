#!/bin/sh

run_s9_new() {
	/usr/bin/time ../s9/s9 -i ../s9/test.image -q <$1
}

run_s9_old() {
	/usr/bin/time env S9FES_LIBRARY_PATH=../s9-old/s9/ ../s9-old/s9/s9 -q <$1
}

run_csi() {
	/usr/bin/time sh -c "echo | csi -w -q <$1"
}

run_mit() {
	/usr/bin/time sh -c "echo | scheme <$1 | sed -ne 's/^;Value [0-9]*: //p'"
}

print_time() {
	echo -n "	$(sed -e 's/ *\([0-9\.]*\) real.*/\1/g' <times)"
}

dd if=/dev/zero of=testfile.in bs=1K count=512

(echo -n "("
 for x in *.scm; do
	echo -n "(`basename $x .scm`"
	run_s9_new $x 2>times >/dev/null; print_time
	run_s9_old $x 2>times >/dev/null; print_time
	run_csi $x 2>times >/dev/null; print_time
	run_mit $x 2>times >/dev/null; print_time
	echo ")"
 done
 echo ")") | tee results.txt

rm -f testfile.in testfile.out
