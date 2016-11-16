#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "intsort.h"


int main(int argc, char *argv[]){
    if (argc != 2) {
        printf("Expected 2 args, got %d", argc);
    }

    /* Open the file.*/
    FILE *file = fopen(argv[1], "r");
    if (!file) {
        exit(EXIT_FAILURE);
    }

    /* Read, sort, and print lines.*/
    char *line = NULL;
    size_t len = 0;
    while (getline(&line, &len, file) != NO_MORE_LINES) {
        print_sorted_line(line);
    }

    /* Clean up after ourselves.*/
    if (line) {
        free(line);
    }
    fclose(file);

    exit(EXIT_SUCCESS);
}


void print_sorted_line(char *line) {
    static int64 buf[MAX_LINE];
    size_t len = parse_int_line(line, buf, MAX_LINE);
    bubble_sort(buf, len);

    for (size_t i = 0; i < len; ++i) {
        printf("%lld ", buf[i]);
    }
    putchar('\n');
    busy_wait();
}


size_t parse_int_line(char *line, int64 *buf, size_t maxsize) {
    int64 parsed;
    char *prev;
    size_t n = 0;

    while (*line != '\0') {
        if (n >= maxsize){
            puts("Integer line too long!");
            exit(EXIT_FAILURE);
        }

        prev = line;
        parsed = strtoll(line, &line, 10);
        if (!parsed && prev == line) {
            break;
        }

        buf[n] = parsed;
        ++n;
    }
    busy_wait();
    return n;
}


void swap(int64 *a, int64 *b) {
    int tmp = *a;
    *a = *b;
    *b = tmp;
}


void bubble_sort(int64 *arr, int len){
    while (len) {
        for (int i = 0; i + 1 < len; ++i) {
            if (arr[i] > arr[i + 1]) {
                swap(arr + i, arr + i + 1);
            }
        }
        --len;
    }
}


volatile int x = 0; /* Needed or else gcc will just optimize this out.*/
void busy_wait(){
    for (int i=0; i < 100000000; ++i){
        if (x) {
            printf("Someone changed x to %d!", x);
        }
    }
}
