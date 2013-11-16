function cropIm(fileName, fileExt)
[img, map] = imread(fileName, fileExt);
imgSize = size(img);

% Граница для обрезки слева
for i = 1:10:imgSize(2)-100
    partVert = img(:,i:i+10,:);
    if find (partVert ~= 255, 1, 'first');
        leftBound = i;
        break;
    end
end
% Граница для обрезки справа
for i = imgSize(2)-12:-10:100
    partVert = img(:,i:i+10,:);
    if find (partVert ~= 255, 1, 'first');
        rightBound = i+10;
        break;
    end
end

% Граница для обрезки cверху
for i = 1:10:imgSize(1)-100
    partGor = img(i:i+10,:,:);
    if find (partGor ~= 255, 1, 'first');
        topBound = i;
        break;
    end
end
% Граница для обрезки cнизу
for i = imgSize(1)-12:-10:100
    partGor = img(i:i+10,:,:);
    if find (partGor ~= 255, 1, 'first');
        bottomBound = i+10;
        break;
    end
end

width = rightBound - leftBound;
height = bottomBound - topBound;

imgCrop = imcrop(img, [leftBound topBound width height]);

if strcmp('tif', fileExt) || ...
   strcmp('jpg', fileExt) || ...
   strcmp('png', fileExt)
     imwrite(imgCrop, [fileName '.' fileExt], fileExt);
elseif strcmp('bmp', fileExt)
     imwrite(imgCrop, map, [fileName '.' fileExt], fileExt);
end

end % function
