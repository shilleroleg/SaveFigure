function saveFig(xName, yName, varargin)
% Функция настраивает график функции и сохраняет в файл
% 
% Аргументы:
%     xName - подпись оси Х
%     yName - подпись оси У 
%    
%     'FigureName' - название файла
%     'LineWidth' - толщина линии
%     'FileExt' -  расширение файла tif', 'bmp', 'jpg', 'png'
%     'FontSize'  - размер шрифта
%     'YAlignment' = 'in' - подпись по У внутри осей
%                  = 'out' - подпись по У вне осей 
%     'XAlignment' = 'in' - подпись по X внутри осей
%                  = 'out' - подпись по X вне осей 
%
% ver. 2
% Значения по умолчанию
figureName = 'Figure';
nLineWidth = 2;
nFontSize = 24; 
fExt = 'bmp';
YVerticalAlignment = 'top';
YHorizontalAlignment = 'right';
XVerticalAlignment = 'top';
XHorizontalAlignment = 'right';
% error(nargchk(2, 3, nargin))

if length(varargin) > 1
    if rem(length(varargin), 2) ~= 0
        disp('Неверное количество аргументов');
        return
    end
    
    for i = 1:2:length(varargin)
        switch char(varargin(i))
            case 'FigureName'
                figureName = char(varargin(i+1));
            case 'LineWidth'
                nLineWidth = cell2mat(varargin(i+1));
            case 'FileExt'
                fExt = char(varargin(i+1));
            case 'FontSize'
                nFontSize = cell2mat(varargin(i+1));
            case 'YAlignment'
                if strcmp(char(varargin(i+1)), 'in')
                    YHorizontalAlignment = 'left';
                elseif strcmp(char(varargin(i+1)), 'out')
                    YHorizontalAlignment = 'right';
                end
             case 'XAlignment'
                if strcmp(char(varargin(i+1)), 'in')
                    XVerticalAlignment = 'bottom';
                elseif strcmp(char(varargin(i+1)), 'out')
                    XVerticalAlignment = 'top';
                end   
            otherwise
                disp('Неизвестный аргумент')
        end   
    end
    
end 
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