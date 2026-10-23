% Лабораторна робота № 4. Статистична обробка даних. Варіант № 4
clear; clc; close all;
warning('off', 'all');
graphics_toolkit('gnuplot');

if exist('lab4.txt', 'file'), delete('lab4.txt'); end
diary lab4.txt;

disp('ЛАБОРАТОРНА РОБОТА № 4. СТАТИСТИЧНА ОБРОБКА ДАНИХ. ВАРІАНТ № 4');

N = 4;
fprintf('Номер варіанта N = %d\n\n', N);

%% 1. Формування масивів даних
disp('--- 1. ФОРМУВАННЯ МАСИВІВ ДАНИХ ВИМІРЮВАНЬ ---');

A1 = linspace(-3*N, 8*N, 30);
disp('Масив A1(30) на проміжку [-3N, 8N] = [-12, 32]:');
disp(A1);

A2 = [linspace(1, 2*N, 15);
      linspace(-N/2, N/2, 15);
      linspace(N-10, N+10, 15)];
h = (A2(:, 15) - A2(:, 1)) / 14;
fprintf('Кроки: h1 = %.4f, h2 = %.4f, h3 = %.4f\n\n', h);
disp('Матриця A2 (розмір 3x15):');
disp(A2);

%% 2. Максимуми та мінімуми
disp('--- 2. МАКСИМАЛЬНІ ТА МІНІМАЛЬНІ ЕЛЕМЕНТИ ---');

[max_A1, i_max] = max(A1);
[min_A1, i_min] = min(A1);
fprintf('A1: max = %.4f (індекс %d), min = %.4f (індекс %d)\n\n', ...
    max_A1, i_max, min_A1, i_min);

disp('Максимуми A2 по стовпчиках:');
disp(max(A2));
disp('Мінімуми A2 по стовпчиках:');
disp(min(A2));
disp('Максимуми A2 по рядках:');
disp(max(A2, [], 2));
disp('Мінімуми A2 по рядках:');
disp(min(A2, [], 2));
fprintf('Загальний максимум матриці A2 = %.4f\n', max(A2(:)));
fprintf('Загальний мінімум матриці A2 = %.4f\n\n', min(A2(:)));

%% 3. Середні, медіани, стандартні відхилення
disp('--- 3. СЕРЕДНІ ЗНАЧЕННЯ, МЕДІАНИ, СТАНДАРТНЕ ВІДХИЛЕННЯ ---');

fprintf('A1: Середнє = %.4f, Медіана = %.4f, Стандартне відхилення = %.4f\n\n', ...
    mean(A1), median(A1), std(A1));

m = mean(A2, 2);
m(abs(m) < 1e-10) = 0;   % прибираємо похибку округлення
disp('Середні значення A2 по рядках:');
disp(m);
disp('Медіани A2 по рядках:');
disp(median(A2, 2));
disp('Стандартні відхилення A2 по рядках:');
disp(std(A2, 0, 2));

%% 4. Сортування
disp('--- 4. СОРТУВАННЯ ЕЛЕМЕНТІВ МАСИВУ ---');

A1_desc = sort(A1, 'descend');
disp('A1, відсортований за спаданням (перші 10 ел.):');
disp(A1_desc(1:10));

disp('A2, sortrows за першим стовпчиком (перші 5 стовпців):');
A2_rows = sortrows(A2, 1);
disp(A2_rows(:, 1:5));

%% 5. Суми, добутки, різниці
disp('--- 5. СУМИ, ДОБУТКИ ТА РІЗНИЦІ ---');

fprintf('A1: Сума = %.4f, Добуток = %.4e\n', sum(A1), prod(A1));
s = sum(A2, 2);  s(abs(s) < 1e-10) = 0;
pr = prod(A2, 2); pr(abs(pr) < 1e-10) = 0;
disp('Суми елементів A2 по рядках:');
disp(s);
fprintf('Добутки елементів A2 по рядках: %.4e  %.4e  %.4e\n', pr);

c = cumsum(A1);
p = cumprod(A2(1, :));
fprintf('cumsum(A1): останній елемент = %.4f\n', c(end));
fprintf('cumprod першого рядка A2: останній елемент = %.4e\n', p(end));

d = diff(A1);
fprintf('Крок A1: diff(A1)(1) = %.4f\n', d(1));
dA2 = diff(A2, 1, 2);
disp('Різниці сусідніх стовпчиків A2 (кроки h1, h2, h3):');
disp(dA2(:, 1));

%% 6. Графіки
disp('--- 6. ПОБУДОВА ГІСТОГРАМИ ТА ГРАФІКІВ ---');

figure(1);
hist(A1, 10);
grid on;
title('Гістограма розподілу значень масиву A1 (10 інтервалів)');
xlabel('Інтервали значень');
ylabel('Частота попадання');
print('lab4_hist.png', '-dpng');
disp('Гістограму збережено як lab4_hist.png');

figure(2);
subplot(2, 1, 1);
plot(1:30, A1, 'b-o', 'LineWidth', 1.5, 'MarkerSize', 4);
grid on;
title('Значення елементів масиву A1');
xlabel('Номер елемента'); ylabel('A1(i)');

subplot(2, 1, 2);
plot(1:30, c, 'r-s', 'LineWidth', 1.5, 'MarkerSize', 4);
grid on;
title('Кумулятивна сума cumsum(A1)');
xlabel('Номер елемента'); ylabel('Сума');
print('lab4_stats.png', '-dpng');
disp('Графік кумулятивної суми збережено як lab4_stats.png');

diary off;

