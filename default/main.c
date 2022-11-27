#include "functions.h"
#include <stdio.h>
#include <time.h>

int main(int argc, char **argv) {
    int repeat = 4000000;
    double a, b, c, eps;
    double result;
    a = 0;
    b = 1;
    c = 0;

    if (!check_range(a, b)) {
        return 1;
    }

    if (argc != 1 && argc != 2 && argc != 3) {
        printf("You need to specify 2 files in the command line arguments: input "
               "and output");
        return 1;
    } else if (argc == 1) {
        eps = enter_eps_from_console();
    } else if (argc == 2) {
        eps = generate_eps();
    } else {
        eps = enter_eps_from_file(argv);
    }

    if (!check_eps(eps)) {
        return 1;
    }

    clock_t first = clock();
    for (int i = 0; i < repeat; ++i) {
        result = calculate(a, b, c, eps);
    }
    clock_t second = clock();
    double gap = (double)(second - first) / CLOCKS_PER_SEC;
    printf("Program execution time:\t%lf\n", gap);

    if (argc == 1 || argc == 2) {
        print_answer_to_console(result);
    } else {
        print_answer_to_file(result, argv);
    }

    return 0;
}