function saveFig2(yName, xName, figureName, nLineWidth, fExt)
% Функция настраивает график функции и сохраняет в файл
% 
% Аргументы:
%    yName - обязательный аргумент - подпись оси У 
%    xName - необязательный аргумент - подпись оси Х
%            по умолчанию 't, c' 
%    figureName - необязательный аргумент - название сохраняемого файла
%                 по умолчанию Figure-(и текущее время)
%    nLineWidth - необязательный аргумент - толщина линий
%                 по умолчанию толщина 2   
%    fExt - необязательный аргумент - расширение сохраняемогофайла
%           по умолчанию 'bmp'
%           допустимые значения 'tif', 'bmp', 'jpg', 'png'
%
% ver. 1

if nargin == 1
    xName = 't, c';       % Подпись оси Х по умолчанию
end

if nargin <= 2            % Название графика по умолчанию
    c = clock;
    figureName = ['Figure-' num2str(c(4)) '-' num2str(c(5)) '-' num2str(round(c(6)))];      
end

if nargin <= 3
    nLineWidth = 2;       % Толщина линий по умолчанию
end

if nargin <= 4
    fExt = 'bmp';         % Расширение файла по умолчанию
end

nFontSize = 24;         % Размер шрифта для подписей

% Включаем сетку
grid on;               
% Устанавливаем размер шрифта и толщину линий
figProp = get(gca);    % Получаем все свойства графика
set(gca, 'FontName', 'Times New Roman', 'FontSize', nFontSize);
set(figProp.Children, 'LineWidth', nLineWidth);

figProp = get(gca);    % Получаем все свойства графика еще раз 
nXLim = figProp.XLim;  % Пределы по оси Х
nYLim = figProp.YLim;  % Пределы по оси У
%% Ось Х
%Подпись оси Х
text(nXLim(2),nYLim(1), xName, ...
    'HorizontalAlignment', 'right',...
    'VerticalAlignment', 'bottom',...
    'FontName', 'Times New Roman',...
    'FontSize', nFontSize);

%% Ось Y
% Предел по оси Y
% set(gca,'YLim', nYLim+nYLim/10);
%Подпись оси Y
text(nXLim(1),nYLim(2), yName, ...
    'HorizontalAlignment', 'left',...
    'VerticalAlignment', 'bottom',...
    'FontName', 'Times New Roman',...
    'FontSize', nFontSize);

%% Сохраняем рисунок с графиком
if exist([figureName '.' fExt], 'file')
    c = clock;
    figureName = [figureName '-' num2str(c(4)) '-' num2str(c(5)) '-' num2str(round(c(6)))];
end

switch fExt
    case 'tif'
        % Сохраняет график в хорошем качестве
        % для печати в журналах рекомендуется увеличить DPI (параметр r)
        % до 600
        print ('-dtiff', '-r600', figureName) 
    case 'bmp'
        saveas(gcf, figureName, 'bmp' );
    case 'jpg'
        print ('-djpeg', '-r300', figureName) 
    case 'png'
        print ('-dpng', '-r300', figureName) 
    otherwise
        disp('Unknown extencion. Save as *.bmp');
        saveas(gcf, figureName, 'bmp' );
end
% Обрезает график
cropIm(figureName, fExt);     

end