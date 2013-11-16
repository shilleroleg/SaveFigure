function saveFig(xName, yName, varargin)
% ������� ����������� ������ ������� � ��������� � ����
% 
% ���������:
%     xName - ������� ��� �
%     yName - ������� ��� � 
%    
%     'FigureName' - �������� �����
%     'LineWidth' - ������� �����
%     'FileExt' -  ���������� ����� tif', 'bmp', 'jpg', 'png'
%     'FontSize'  - ������ ������
%     'YAlignment' = 'in' - ������� �� � ������ ����
%                  = 'out' - ������� �� � ��� ���� 
%     'XAlignment' = 'in' - ������� �� X ������ ����
%                  = 'out' - ������� �� X ��� ���� 
%
% ver. 2
% �������� �� ���������
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
        disp('�������� ���������� ����������');
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
                disp('����������� ��������')
        end   
    end
    
end 
% �������� �����
grid on;               
% ������������� ������ ������ � ������� �����
figProp = get(gca);    % �������� ��� �������� �������
set(gca, 'FontName', 'Times New Roman', 'FontSize', nFontSize);
set(figProp.Children, 'LineWidth', nLineWidth);

figProp = get(gca);    % �������� ��� �������� ������� ��� ��� 
nXLim = figProp.XLim;  % ������� �� ��� �
nYLim = figProp.YLim;  % ������� �� ��� �

%% ��� �
% ������� �� ��� X ��� ���������� ��������
if strcmp(XVerticalAlignment, 'top')
    set(gca,'XTick', figProp.XTick(1:end-1));
end
%������� ��� �
text(nXLim(2),nYLim(1), xName, ...
    'HorizontalAlignment', XHorizontalAlignment,...
    'VerticalAlignment', XVerticalAlignment,...
    'FontName', 'Times New Roman',...
    'FontSize', nFontSize);

%% ��� Y
% ������� �� ��� Y ��� ���������� ��������
if strcmp(YHorizontalAlignment, 'right')
    set(gca,'YTick', figProp.YTick(1:end-1));
end
%������� ��� Y
text(nXLim(1),nYLim(2), yName, ...
    'HorizontalAlignment', YHorizontalAlignment,...
    'VerticalAlignment', YVerticalAlignment,...
    'FontName', 'Times New Roman',...
    'FontSize', nFontSize);

%% ��������� ������� � ��������
if exist([figureName '.' fExt], 'file')
    c = clock;
    figureName = [figureName '-' num2str(c(4)) '-' num2str(c(5)) '-' num2str(round(c(6)))];
end

switch fExt
    case 'tif'
        % ��������� ������ � ������� ��������
        % ��� ������ � �������� ������������� ��������� DPI (�������� r)
        % �� 600
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
% �������� ������
cropIm(figureName, fExt);     

end