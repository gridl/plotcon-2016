typedef long long int int64;

#define MAX_LINE 100000
#define NO_MORE_LINES -1

void busy_wait(void);
void bubble_sort(int64 *arr, int len);
void recursive_bubble_sort(int64 *arr, int len);
void print_sorted_line(char *line);
size_t parse_int_line(char *line, int64 *buf, size_t maxsize);
void swap(int64 *a, int64 *b);
