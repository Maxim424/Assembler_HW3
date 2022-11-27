#include <stdio.h>
#include <time.h>
#include <math.h>
#include <stdlib.h>

double f(double x)
{
    return pow(2, pow(x, 2) + 1) + pow(x, 2) - 4;
}

int check_range(double a, double b) {
    printf("Range from a to b, where\n\ta = %lf\n\tb = %lf\n", a, b);
    if (f(a) * f(b) < 0) {
        printf("The range is correct.\n");
        return 1;
    } else {
        printf("The range is incorrect, there is no solution from a to b or more than 1 solution.");
        return 0;
    }
}

double enter_eps_from_console() {
    printf("Enter a number with which accuracy you want to print the solution of the equation:\n");
    double eps;
    scanf("%lf", &eps);
    return eps;
}

double enter_eps_from_file(char **argv) {
    FILE *f = fopen(argv[1], "r");
    double eps;
    fscanf(f, "%lf", &eps);
    fclose(f);
    return eps;
}

double generate_eps() {
    srand (time(0));
    double n = rand() % 5 + 3;
    double eps = 0.1;
    for (int i = 0; i < n; ++i) {
        eps *= 0.1;
    }
    printf("The number with which accuracy the solution of the equation will be printed: %.10lf\n", eps);
    return eps;
}

int check_eps(double eps) {
    if (eps > 0.001 || eps < 0.00000001) {
        printf("Incorrect number = %.10lf\n", eps);
        return 0;
    }
    return 1;
}

double calculate(double a, double b, double c, double eps) {
    while (b - a > eps){
        c = (a + b) / 2;
        if (f(b) * f(c) < 0) {
            a = c;
        } else {
            b = c;
        }
    }
    return c;
}

void print_answer_to_console(double result) {
    printf("Answer: %.10lf\n", result);
}

void print_answer_to_file(double result, char **argv) {
    FILE *f = fopen(argv[2],"w+");\
    printf("The result is written to the file!");
    fprintf(f, "Answer: %.10lf\n", result);
    fclose(f);
}