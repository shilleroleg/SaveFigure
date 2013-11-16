function saveFig(xName, yName, varargin)
% ������� ����������� ������ ������� � ��������� � ����
% 
% ���������:
%     xName - ������� ��� �
%     yName - ������� ��� � 
%    
%     'FigureName' - �������� �����
%     'LineWidth' - ������� �����
%     'FileExt' -  ���������� ����� 'tif', 'bmp', 'jpg', 'png'
%     'FontSize'  - ������ ������
%     'YAlignment' = 'in' - ������� �� � ������ ����
%                  = 'out' - ������� �� � ��� ���� 
%     'XAlignment' = 'in' - ������� �� X ������ ����
%                  = 'out' - ������� �� X ��� ���� 
%
% ������ ������:
% 			saveFig('t, c',  'U,��',   'FigureName', 'Figure_1',...
%					  'LineWidth', 2, 'FontSize', 18,...
%					  'FileExt','tif',...
%					  'YAlignment', 'out',  'XAlignment', 'out');
%
% ver. 3.2
%
%% �������� �� ���������
figureName = 'Figure';
nLineWidth = 2;
nFontSize = 24; 
fExt = 'bmp';
YAlignment = 'out';
XAlignment = 'out';
YVerticalAlignment = 'top';
XHorizontalAlignment = 'right';
% ������ ��������� ������
p = inputParser;
% ������������ ���������
addRequired(p,'xName');
addRequired(p,'yName');
% �������������� ���������
addOptional(p,'FigureName', figureName);
addOptional(p,'LineWidth', nLineWidth, @isnumeric);
addOptional(p,'FontSize', nFontSize, @isnumeric);
checkExt = @(s1) any(strcmp(s1,{'tif','tiff','bmp','jpg','png'}));
addOptional(p,'FileExt', fExt, checkExt);
checkYAlignment = @(s2) any(strcmp(s2,{'in','out'}));
addOptional(p,'YAlignment', YAlignment, checkYAlignment);
checkXAlignment = @(s3) any(strcmp(s3,{'in','out'}));
addOptional(p,'XAlignment', XAlignment, checkXAlignment);
%% �������� �������� ��������� ��������� ������
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
%% �������� �����
grid on;               
% ������������� ������ ������ � ������� �����
figProp = get(gca);    % �������� ��� �������� �������
set(gca, 'FontName', 'Times New Roman', 'FontSize', nFontSize);
set(figProp.Children, 'LineWidth', nLineWidth);

% figProp = get(gca);    % �������� ��� �������� ������� ��� ��� 
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


% F = getframe(gcf);

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