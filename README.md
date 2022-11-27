# Assembler_HW3

Кузнецов Максим Вадимович. БПИ219. Вариант 32

# Условие
Разработать программу, определяющую корень уравнения 2^(x^2+1) + x^2 − 4 = 0 методом половинного деления с точностью от 0,001 до 0,00000001 в диапазоне [0;1]. Если диапазон некорректен, то подобрать корректный диапазон.

## Задание выполнялось по критериям на оценку 8
- Решение без форматирования и оптимизации находится в папке default
- Решение с оптимизацией ассемблерного кода (замена обращений к стеку на регистры, комментирование и отсутствие лишних директив) находится в папке optimised
- В папке tests находятся входные и выходные данные для тестирования
- На вход подается одно вещественное число - точность вычисления корня (по условию оно может быть от 0.00000001 до 0.001)
- В аргументах командной строки можно указать, как вводить данные: через консоль, через файл или с использованием генерации
- Пример запуска программы для ввода через консоль: `./main`
- Пример запуска программы для ввода и вывода через файл: `./main ../tests/input/test1.txt ../tests/output/test1.txt`
- Пример запуска программы для ввода с использованием генерации случайного числа: `./main 1` (в качестве аргумента командной строки может быть указано одно любое число)
- Присутствует обработка некорректных входных данных
- В ассемблерных файлах есть подробные комментарии
- Результаты тестовых прогонов одинаковы для всех указанных программ (default и optimised)
- Программа всегда выполняется в режиме многократного зацикливания, чтобы время выполнения превышало 1 секунду. Это поможет наглядно продемонстрировать разницу во времени выполнения программ с оптимизацией (ассемблерная) и без нее (на C)
- Время выполнения программы всегда выводится в консоль

***
Для преобразования кода на C в ассемблерный код была использована команда:

``gcc -masm=intel -fno-asynchronous-unwind-tables -fno-jump-tables -fno-stack-protector -fno-exceptions ./task.c -S -o ./task_1.s``

``-masm=intel`` нужен для того, чтобы использовался синтаксис intel

``-fno-asynchronous-unwind-tables`` убирает отладочную информацию

``-fno-jump-tables`` позволяет не использовать таблицы переходов

``-fno-stack-protector`` защищает от "stack overflow attacks"

``-fno-exceptions`` нужен для правильной работы с исключениями
***

Изменения в функции main:
- Вместо 8[rsp] используется регистр xmm8 (в метке .L6)
- Вместо 8[rsp] используется регистр xmm15 (в метке .L9 и далее)


Изменения в функции f:
- Вместо 8[rsp] используется регистр xmm14


Изменения в функции check_range:
- Вместо 8[rsp] используется регистр xmm12
- Вместо [rsp] используется регистр xmm13


Изменения в функции generate_eps:
- Вместо 8[rsp] используется регистр xmm12


Изменения в функции calculate:
- Вместо 40[rsp] используется регистр xmm12
- Вместо 32[rsp] используется регистр xmm13


Изменения в функции print_answer_to_file:
- Вместо 8[rsp] используется регистр xmm12

***

### Тест 1
input: `0.0001`
output: `Answer: 0.8458862305`

### Тест 2
input: `0.000001`
output: `Answer: 0.8459444046`

### Тест 3
input: `0.1`
output: `Incorrect number = 0.1000000000`

### Тест 4
input: `0`
output: `Incorrect number = 0.0000000000`

### Тест 5
input: `-50`
output: `Incorrect number = -50.0000000000`
***

### Сопоставление размеров программы на ассемблере, полученной после компиляции с языка C с модифицированной программой, использующей регистры

1. После модификации
- В файле `functions.o` 201 строка (12КБ)
- В файле `main.o` 93 строки (8КБ)
- В файле `main` 441 строка (66КБ)

2. До модификации
- В файле `functions.o` 215 строк (13КБ)
- В файле `main.o` 90 строк (8КБ)
- В файле `main` 430 строк (66КБ)

### Сопоставление времени выполнения программ на C и на ассемблере с модификациями

Время указано в секундах.

   input | Время на C | Время на ассемблере с модификациями
 --------|------------|------------------------------------
   0.001 |   2.717681 |  2.609225
  0.0005 |   2.923865 |  2.898944
  0.0001 |   3.504918 |  3.395960
 0.00005 |   3.909371 |  3.897620
 0.00001 |   4.243798 |  4.225580
0.000005 |   4.786018 |  4.695008
0.000001 |   4.953651 |  4.970234
0.0000005|   5.047574 |  4.958556
0.0000001|   6.274863 |  5.827197
0.00000005|   6.384027 |  6.220091
0.00000001|   6.833578 |  6.427967

Получаем, что почти всегда модифицированная программа работает быстрее.
   
