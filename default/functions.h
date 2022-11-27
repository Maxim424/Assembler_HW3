#ifndef HW3_FUNCTIONS_H
#define HW3_FUNCTIONS_H
double f(double x);

int check_range(double a, double b);

double enter_eps_from_console();

double enter_eps_from_file(char **argv);

double generate_eps();

int check_eps(double eps);

double calculate(double a, double b, double c, double eps);

void print_answer_to_console(double result);

void print_answer_to_file(double result, char **argv);
#endif
