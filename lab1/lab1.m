clear;
clc;
pkg load symbolic;

diary lab1.txt;

% 1. Введення даних
x = input('Enter x: ');
y = input('Enter y: ');
z = input('Enter z: ');

% 2. Числові обчислення
term1 = log10(x^2 + cos(y) + atan(z^2 / 4) + 3);
term2 = ((y^2 + z^2 - 3*x*y + 1.1)^2 + 0.8)^(1/3);
a = exp(-x*y*z) * (term1 + term2)

chis = 1 + sqrt(abs(x) + 2 + (y + z)^2);
znam = ((2.5 + x^3)^2) * (1 + (cos(z))^2);
b = sin(z) + sqrt(1 + 3.1 * abs(x^2 - y^2)) * (chis / znam)

% 3. змінні для формул
syms X Y Z;

% 4. Перевірка формули a
disp('--- Символьна перевірка формули a ---');
t1 = log10(X^2 + cos(Y) + atan(Z^2 / 4) + 3);
t2 = ((Y^2 + Z^2 - 3*X*Y + 1.1)^2 + 0.8)^(1/3);
a_sym = exp(-X*Y*Z) * (t1 + t2);
pretty(a_sym)

% 5. Перевірка формули b
disp('--- Символьна перевірка формули b ---');
t3 = 1 + sqrt(abs(X) + 2 + (Y + Z)^2);
t4 = ((2.5 + X^3)^2) * (1 + (cos(Z))^2);
b_sym = sin(Z) + sqrt(1 + 3.1 * abs(X^2 - Y^2)) * (t3 / t4);
pretty(b_sym)

diary off;
