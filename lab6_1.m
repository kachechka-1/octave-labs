% Лабораторна робота № 6. Розгалужені обчислювальні процеси. Завдання 1. Варіант № 4
%       | 2.3*(x-1.3)^(1/3) + sin(x)^2,   x > 2
%   y = | arccos(x/2) + 2^(3x),          -2 <= x <= 2
%       | |x|^sin(x) - lg|x+1.5|,         x < -2
clc; clear; close all;

disp('ЛАБОРАТОРНА РОБОТА № 6. РОЗГАЛУЖЕНІ ПРОЦЕСИ. ЗАВДАННЯ 1. ВАРІАНТ № 4');

%% Спосіб 1. Оператор if ... elseif ... else (input / disp)
x = input('Введіть x = ');

if x > 2
    y = 2.3 * nthroot(x - 1.3, 3) + sin(x)^2;
    branch = 1;
elseif (x >= -2) & (x <= 2)
    y = acos(x / 2) + 2^(3 * x);
    branch = 2;
else
    y = abs(x)^sin(x) - log10(abs(x + 1.5));
    branch = 3;
end

fprintf('Обчислено за гілкою %d\n', branch);
disp(sprintf('y = %g;', y));

%% Спосіб 2. Діалогове вікно (inputdlg)
prompt    = {'Введіть x:', 'Результат y:'};
dlg_title = 'Лабораторна № 6. Розгалуження';
num_lines = 1;
x = inputdlg(prompt, dlg_title, num_lines);
x = str2double(x{1});

if x > 2
    y = 2.3 * nthroot(x - 1.3, 3) + sin(x)^2;
elseif (x >= -2) & (x <= 2)
    y = acos(x / 2) + 2^(3 * x);
else
    y = abs(x)^sin(x) - log10(abs(x + 1.5));
end

answer = inputdlg(prompt, dlg_title, num_lines, {num2str(x), num2str(y)});

%% Графік функції y(x) на проміжку [-4, 4] (логічні маски замість if)
xx = -4 : 0.01 : 4;
yy = zeros(size(xx));
k1 = xx > 2;
k2 = (xx >= -2) & (xx <= 2);
k3 = xx < -2;
yy(k1) = 2.3 * nthroot(xx(k1) - 1.3, 3) + sin(xx(k1)).^2;
yy(k2) = acos(xx(k2) / 2) + 2.^(3 * xx(k2));
yy(k3) = abs(xx(k3)).^sin(xx(k3)) - log10(abs(xx(k3) + 1.5));

figure(1);
plot(xx(k3), yy(k3), 'b-', xx(k2), yy(k2), 'r-', xx(k1), yy(k1), 'g-', ...
     'LineWidth', 1.5);
grid on;
title('Графік кусково-заданої функції y(x), варіант 4');
xlabel('x'); ylabel('y');
legend('x < -2', '-2 <= x <= 2', 'x > 2', 'Location', 'northwest');
print('lab6_graph.png', '-dpng');
