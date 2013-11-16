function saveFig2(yName, xName, figureName, nLineWidth, fExt)
% ������� ����������� ������ ������� � ��������� � ����
% 
% ���������:
%    yName - ������������ �������� - ������� ��� � 
%    xName - �������������� �������� - ������� ��� �
%            �� ��������� 't, c' 
%    figureName - �������������� �������� - �������� ������������ �����
%                 �� ��������� Figure-(� ������� �����)
%    nLineWidth - �������������� �������� - ������� �����
%                 �� ��������� ������� 2   
%    fExt - �������������� �������� - ���������� �����������������
%           �� ��������� 'bmp'
%           ���������� �������� 'tif', 'bmp', 'jpg', 'png'
%
% ver. 1

if nargin == 1
    xName = 't, c';       % ������� ��� � �� ���������
end

if nargin <= 2            % �������� ������� �� ���������
    c = clock;
    figureName = ['Figure-' num2str(c(4)) '-' num2str(c(5)) '-' num2str(round(c(6)))];      
end

if nargin <= 3
    nLineWidth = 2;       % ������� ����� �� ���������
end

if nargin <= 4
    fExt = 'bmp';         % ���������� ����� �� ���������
end

nFontSize = 24;         % ������ ������ ��� ��������

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
%������� ��� �
text(nXLim(2),nYLim(1), xName, ...
    'HorizontalAlignment', 'right',...
    'VerticalAlignment', 'bottom',...
    'FontName', 'Times New Roman',...
    'FontSize', nFontSize);

%% ��� Y
% ������ �� ��� Y
% set(gca,'YLim', nYLim+nYLim/10);
%������� ��� Y
text(nXLim(1),nYLim(2), yName, ...
    'HorizontalAlignment', 'left',...
    'VerticalAlignment', 'bottom',...
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