% Лабораторна робота № 5. Програми лінійної структури. Варіант № 4
% Задача: дано сторони a, b, c трикутника. Знайти площу трикутника
% за формулою Герона: S = sqrt(p(p-a)(p-b)(p-c)), де p - півпериметр.
% Введення/виведення - у вікні з комірками: p і S перераховуються одразу
% після зміни a, b або c (Enter або перехід в іншу комірку).
clc; clear;

% Перерахунок p і S за значеннями з комірок a, b, c
function recalc(h)
  a = str2double(get(h(1), 'String'));
  b = str2double(get(h(2), 'String'));
  c = str2double(get(h(3), 'String'));

  if any(isnan([a b c]))
    set(h(4:5), 'String', 'введіть числа');
    return;
  end
  if any([a b c] <= 0) || a >= b + c || b >= a + c || c >= a + b
    set(h(4:5), 'String', 'трикутник не існує');
    return;
  end

  p = (a + b + c) / 2;                       % півпериметр
  S = sqrt(p * (p - a) * (p - b) * (p - c)); % формула Герона

  set(h(4), 'String', num2str(p));
  set(h(5), 'String', num2str(S));
end

names = {'Сторона a =', 'Сторона b =', 'Сторона c =', ...
         'Півпериметр p =', 'Площа S ='};
start = {'3', '4', '5', '', ''};

fig = figure('Name', 'Лабораторна № 5. Формула Герона', 'NumberTitle', 'off', ...
             'MenuBar', 'none', 'ToolBar', 'none', 'Position', [400 300 260 330]);

h = zeros(1, 5);
for k = 1:5
  y = 330 - k*60;
  uicontrol(fig, 'Style', 'text', 'String', names{k}, ...
            'HorizontalAlignment', 'left', 'Position', [15 y+25 230 20]);
  h(k) = uicontrol(fig, 'Style', 'edit', 'String', start{k}, ...
                   'BackgroundColor', 'w', 'HorizontalAlignment', 'left', ...
                   'Position', [15 y 230 25]);
end

set(h(4:5), 'Enable', 'inactive');              % p і S лише для читання
set(h(1:3), 'Callback', @(src, evt) recalc(h));
recalc(h);
