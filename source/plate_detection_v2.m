im = imread('P9170011.jpg');

L = rgb2gray(im2double(im));
t = graythresh(L);
L1 = L > t;

% Try to fill holes
C1 = imgaussfilt(L, 4);
E1 = edge(C1, 'canny'); % edge detection
H1 = imfill(E1, "holes"); % fill holes
H2 = bwconncomp(H1);

%% use morphology for remove noices
SE = strel('disk', 11);
imo = imopen(H1, SE);

figure, imshow([L, L1, H1, imo]);

%% Below steps are to find location of number plate
% regionprops for find a bounding box
Iprops=regionprops(imo,'BoundingBox','Area', 'Image');
boundingBox = Iprops.BoundingBox;
boundingBox; %% show bounding box

cropped_result_for_2nd = imcrop(L1, boundingBox);
cropped_result = imcrop(im, boundingBox);%crop the number plate area

%figure, imshow(cropped_result)
%% after crop the plate resutlt stored result2


%% ============ 2nd part====================

symbol_detection(cropped_result);


%% ============== 3rd part=================
ocr = ocr(cropped_result);
ocr; %%  in case OCR doesn't working for result



