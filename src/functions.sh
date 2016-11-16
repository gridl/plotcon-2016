export PATH="vendor/FlameGraph:$PATH"
export PS1="$ "

function print-lines(){
    trap 'echo "Running: $BASH_COMMAND"' DEBUG
}

function compile-intsort() {
    (
        print-lines
        gcc -g src/intsort.c -o intsort
        gcc -g src/intsort_recursive.c -o intsort_recursive
    )
}

function record-perf() {
    (
        print-lines
        perf record -F 75 -g -- $@
    )
}

function make-ints() {
    (
        print-lines
        python src/make_lots_of_ints.py 5 10 > inputs/not_many_ints.txt
        python src/make_lots_of_ints.py 15 10000 > inputs/too_many_ints.txt
        python src/make_lots_of_ints.py 20 50000 > inputs/way_too_many_ints.txt
    )
}

function make-flamegraph() {
    (
        print-lines
        perf script | stackcollapse-perf.pl | flamegraph.pl --width 1900 > $1
        google-chrome $1
    )
}


function run-intsort-perf() {
    (
        print-lines
        perf record -F 75 -g -- ./intsort inputs/too_many_ints.txt > sorted_ints.txt
        perf script | stackcollapse-perf.pl | flamegraph.pl --width 1900 > intsort-flame.svg
        google-chrome intsort-flame.svg
    )
}

function run-intsort-recursive-perf() {
    (
        print-lines
        perf record -F 75 -g -- ./intsort_recursive inputs/too_many_ints.txt > sorted_ints.txt
        perf script | stackcollapse-perf.pl | flamegraph.pl --width 1900 > intsort-recursive-flame.svg
    )
}

function make-histogram-flamegraph() {
    (
        perf record -F 100 -g -- python src/histogram.py inputs/way_too_many_ints.txt int-histogram.png
        perf script | stackcollapse-perf.pl | flamegraph.pl --width 1900 > histogram-flamegraph.svg
        google-chrome histogram-flamegraph.svg
    )
}

function profile-histogram() {
    python -m cProfile -o stats.dat src/histogram.py inputs/way_too_many_ints.txt int-histogram.png
}
