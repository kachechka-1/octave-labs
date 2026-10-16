% Лабораторна робота №3. Двовимірна графіка. Варіант 4
clear; clc; close all;
warning('off', 'all');

if exist('lab3.txt', 'file')
    delete('lab3.txt');
end
diary lab3.txt;

disp('ЛАБОРАТОРНА РОБОТА № 3. ДВОВИМІРНА ГРАФІКА. ВАРІАНТ № 4');

%% Задача 1. Графічне розв'язання системи
disp('--- ЗАДАЧА 1 ---');
disp('  -4*x + 7*z^2 = 21   =>  x = (7*z^2 - 21) / 4');
disp('  14*x^2 - 2*z = -6   =>  z = 7*x^2 + 3');

z1 = -3 : 0.01 : 3;
x1 = (7 * z1.^2 - 21) / 4;

x2 = -6 : 0.01 : 4;
z2 = 7 * x2.^2 + 3;

% підстановка z = 7x^2 + 3 у перше рівняння: 343x^4 + 294x^2 - 4x + 42 = 0
D = (-4)^2 - 4*294*42;
fprintf('D = %d < 0  =>  294x^2 - 4x + 42 > 0, а 343x^4 >= 0\n', D);
disp('Отже 343x^4 + 294x^2 - 4x + 42 > 0, розв''язків немає, графіки не перетинаються');

% перевірка через solve (пакет symbolic)
pkg load symbolic
syms x z
s = solve(-4*x + 7*z^2 == 21, 14*x^2 - 2*z == -6, x, z);
disp('Розв''язки системи через solve:');
for k = 1:numel(s)
    xk = double(s{k}.x);
    zk = double(s{k}.z);
    fprintf('  x = %.4f %+.4fi,   z = %.4f %+.4fi\n', real(xk), imag(xk), real(zk), imag(zk));
end
disp('Усі розв''язки комплексні => дійсних розв''язків немає');

% перевірка інтерполяцією: між вузлами криві теж не перетинаються
zq = -3 : 0.0001 : 3;
xq = -6 : 0.0001 : 4;
disp('Перевірка interp1 (пряма z = 3 розділяє криві):');
for m = {'linear', 'nearest', 'pchip', 'spline'}
    x1q = interp1(z1, x1, zq, m{1});
    z2q = interp1(x2, z2, xq, m{1});
    fprintf('  %-7s крива 1: z <= %.1f (при z = 3 x = %.1f),  крива 2: z >= %.4f\n', ...
            m{1}, max(zq), x1q(end), min(z2q));
end
disp('Спільна точка можлива лише при z = 3, але там x = 10.5 > 4 => перетину немає');

figure(1);
plot(x1, z1, 'b-', 'LineWidth', 2);
hold on;
plot(x2, z2, 'r--', 'LineWidth', 2);
grid on;
axis([-6 4 -3 8]);
title('Задача 1. Графічне розв''язання системи');
xlabel('x');
ylabel('z');
legend('-4x + 7z^2 = 21', '14x^2 - 2z = -6', 'Location', 'SouthEast');
print('lab3_task1.png', '-dpng');

%% Задача 2. Графік функції на [-N, N]
disp('--- ЗАДАЧА 2 ---');
N = 4;
a = 2;
b = 0.5;
h = 0.1;
fprintf('N = %d, a = %.1f, b = %.1f, h = %.1f\n', N, a, b, h);
disp('y = b*sqrt(a^3 + x^3) / exp(-b*x)');

x = -N : h : N;
u = a^3 + x.^3;
y = b * sqrt(max(u, 0)) ./ exp(-b * x);
y(u < 0) = NaN;   % поза областю визначення (x < -a)

ok = find(~isnan(y));
fprintf('Функція визначена при x >= %.1f\n', x(ok(1)));
for i = ok(1:5)
    fprintf('  x = %5.2f   y = %9.4f\n', x(i), y(i));
end
i0 = find(abs(x) < 1e-9);
fprintf('  x = %5.2f   y = %9.4f\n', x(i0), y(i0));
fprintf('  x = %5.2f   y = %9.4f\n', x(end), y(end));

figure(2);
plot(x, y, 'm-x', 'LineWidth', 2);
grid on;
xlim([-N N]);
title('Задача 2. y = b*sqrt(a^3 + x^3) / e^{-bx}');
xlabel('x');
ylabel('y');
legend('y(x)', 'Location', 'NorthWest');
print('lab3_task2.png', '-dpng');

%% Обидва графіки в одному вікні
figure(3);
subplot(2, 1, 1);
plot(x1, z1, 'b-', x2, z2, 'r--', 'LineWidth', 2);
grid on;
axis([-6 4 -3 8]);
title('Задача 1');
xlabel('x'); ylabel('z');

subplot(2, 1, 2);
plot(x, y, 'm-', 'LineWidth', 2);
grid on;
xlim([-N N]);
title('Задача 2');
xlabel('x'); ylabel('y');
print('lab3_all.png', '-dpng');

diary off;
