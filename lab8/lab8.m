% Лабораторна робота № 8. Оптимальний план випуску БПЛА. Варіант № 4
% Задача лінійного програмування: F = f(1)*x1 + f(2)*x2 -> max,  A*x <= b,  x >= 0.
% Вікно з полями f, A, b і кнопкою «Розрахувати» (аналог застосунку App Designer).
% Замість linprog (MATLAB) використано вбудовану в Octave функцію glpk.
clc; clear;

% Обробник натискання кнопки «Розрахувати»
function SolveButtonPushed(app)
  % зчитати дані з полів
  f = str2num(get(app.fEditField, 'String'));
  A = str2num(get(app.AEditField, 'String'));
  b = str2num(get(app.bEditField, 'String'));

  if isempty(f) || isempty(A) || isempty(b) || numel(f) ~= 2 || numel(f) ~= size(A, 2) || numel(b) ~= size(A, 1)
    set([app.x1EditField app.x2EditField app.FvalEditField], 'String', 'помилка в даних');
    return;
  end

  % розв'язати задачу: glpk, як і linprog, шукає мінімум, тому передаємо -f
  lb = zeros(numel(f), 1);
  ctype = repmat('U', 1, numel(b));          % усі обмеження вигляду A*x <= b
  vartype = repmat('C', 1, numel(f));        % змінні неперервні
  [x, fval, err, extra] = glpk(-f(:), A, b(:), lb, [], ctype, vartype, 1);

  if err ~= 0 || extra.status ~= 5 || isnan(fval)
    set([app.x1EditField app.x2EditField app.FvalEditField], 'String', 'розв''язку немає');
    return;
  end

  % вивести результат у поля
  set(app.x1EditField, 'String', num2str(x(1)));
  set(app.x2EditField, 'String', num2str(x(2)));
  set(app.FvalEditField, 'String', num2str(-fval));
end

% Створення вікна
fig = figure('Name', 'Оптимальний план випуску БПЛА', 'NumberTitle', 'off', ...
             'MenuBar', 'none', 'ToolBar', 'none', 'Position', [400 300 560 260]);

% Поля вхідних даних (варіант 4)
labels_in = {'Прибуток f', 'Матриця A', 'Запаси b'};
values_in = {'[14 20]', '[5 26; 2 0; 10 30; 8 12]', '[600; 24; 630; 380]'};
h_in = zeros(1, 3);
for k = 1:3
  y = 200 - (k-1)*45;
  uicontrol(fig, 'Style', 'text', 'String', labels_in{k}, ...
            'HorizontalAlignment', 'right', 'Position', [10 y 90 25]);
  h_in(k) = uicontrol(fig, 'Style', 'edit', 'String', values_in{k}, ...
                      'BackgroundColor', 'w', 'HorizontalAlignment', 'left', ...
                      'Position', [110 y 200 25]);
end

% Поля результату
labels_out = {'БПЛА-А, x1', 'БПЛА-Б, x2', 'Прибуток, тис. грн'};
h_out = zeros(1, 3);
for k = 1:3
  y = 200 - (k-1)*45;
  uicontrol(fig, 'Style', 'text', 'String', labels_out{k}, ...
            'HorizontalAlignment', 'right', 'Position', [320 y 120 25]);
  h_out(k) = uicontrol(fig, 'Style', 'edit', 'String', '', 'Enable', 'inactive', ...
                       'BackgroundColor', 'w', 'Position', [450 y 90 25]);
end

% Імена компонентів, як у таблиці 2 методички
app.fEditField    = h_in(1);
app.AEditField    = h_in(2);
app.bEditField    = h_in(3);
app.x1EditField   = h_out(1);
app.x2EditField   = h_out(2);
app.FvalEditField = h_out(3);

% Кнопка «Розрахувати»
app.SolveButton = uicontrol(fig, 'Style', 'pushbutton', 'String', 'Розрахувати', ...
                            'Position', [110 40 200 35], ...
                            'Callback', @(src, evt) SolveButtonPushed(app));
