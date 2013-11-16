function saveFig(xName, yName, varargin)
% Функция настраивает график функции и сохраняет в файл
% 
% Аргументы:
%     xName - подпись оси Х
%     yName - подпись оси У 
%    
%     'FigureName' - название файла
%     'LineWidth' - толщина линии
%     'FileExt' -  расширение файла 'tif', 'bmp', 'jpg', 'png'
%     'FontSize'  - размер шрифта
%     'YAlignment' = 'in' - подпись по У внутри осей
%                  = 'out' - подпись по У вне осей 
%     'XAlignment' = 'in' - подпись по X внутри осей
%                  = 'out' - подпись по X вне осей 
%
% Пример вызова:
% 			saveFig('t, c',  'U,кВ',   'FigureName', 'Figure_1',...
%					  'LineWidth', 2, 'FontSize', 18,...
%					  'FileExt','tif',...
%					  'YAlignment', 'out',  'XAlignment', 'out');
%
% ver. 3.2
%
%% Значения по умолчанию
figureName = 'Figure';
nLineWidth = 2;
nFontSize = 24; 
fExt = 'bmp';
YAlignment = 'out';
XAlignment = 'out';
YVerticalAlignment = 'top';
XHorizontalAlignment = 'right';
% Парсим командную строку
p = inputParser;
% Обязательные параметры
addRequired(p,'xName');
addRequired(p,'yName');
% Необязательные параметры
addOptional(p,'FigureName', figureName);
addOptional(p,'LineWidth', nLineWidth, @isnumeric);
addOptional(p,'FontSize', nFontSize, @isnumeric);
checkExt = @(s1) any(strcmp(s1,{'tif','tiff','bmp','jpg','png'}));
addOptional(p,'FileExt', fExt, checkExt);
checkYAlignment = @(s2) any(strcmp(s2,{'in','out'}));
addOptional(p,'YAlignment', YAlignment, checkYAlignment);
checkXAlignment = @(s3) any(strcmp(s3,{'in','out'}));
addOptional(p,'XAlignment', XAlignment, checkXAlignment);
%% Получаем валидные параметры командной строки
parse(p, xName, yName, varargin{:});
xName = p.Results.xName;
yName = p.Results.yName;
figureName = p.Results.FigureName;
nLineWidth = p.Results.LineWidth;
nFontSize = p.Results.FontSize;
fExt = p.Results.FileExt;
    if strcmp(fExt, 'tiff')
        fExt = 'tif'; 
    end
YAlignment = p.Results.YAlignment;
    if strcmp(YAlignment, 'in')
        YHorizontalAlignment = 'left';
    elseif strcmp(YAlignment, 'out')
        YHorizontalAlignment = 'right';
        YVerticalAlignment = 'middle';
    end
XAlignment = p.Results.XAlignment;
    if strcmp(XAlignment, 'in')
        XVerticalAlignment = 'bottom';
    elseif strcmp(XAlignment, 'out')
        XVerticalAlignment = 'top';
    end
%% Включаем сетку
grid on;               
% Устанавливаем размер шрифта и толщину линий
figProp = get(gca);    % Получаем все свойства графика
set(gca, 'FontName', 'Times New Roman', 'FontSize', nFontSize);
set(figProp.Children, 'LineWidth', nLineWidth);

% figProp = get(gca);    % Получаем все свойства графика еще раз 
nXLim = figProp.XLim;  % Пределы по оси Х
nYLim = figProp.YLim;  % Пределы по оси У

%% Ось Х
% Подпись по оси X без последнего элемента
if strcmp(XVerticalAlignment, 'top')
    set(gca,'XTick', figProp.XTick(1:end-1));
end
%Подпись оси Х
text(nXLim(2),nYLim(1), xName, ...
    'HorizontalAlignment', XHorizontalAlignment,...
    'VerticalAlignment', XVerticalAlignment,...
    'FontName', 'Times New Roman',...
    'FontSize', nFontSize);

%% Ось Y
% Подпись по оси Y без последнего элемента
if strcmp(YHorizontalAlignment, 'right')
    set(gca,'YTick', figProp.YTick(1:end-1));
end
%Подпись оси Y
text(nXLim(1),nYLim(2), yName, ...
    'HorizontalAlignment', YHorizontalAlignment,...
    'VerticalAlignment', YVerticalAlignment,...
    'FontName', 'Times New Roman',...
    'FontSize', nFontSize);


% F = getframe(gcf);

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