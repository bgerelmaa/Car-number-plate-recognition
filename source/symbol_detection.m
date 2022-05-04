function symbol_detection(image)
     %% Try to use black and white image detection
     % Here, I suggest black and white object detection. 
     % Histogram adjustment, thresholding, and connected component analysis may be utilized.
    rgb_result =  rgb2gray(im2double(image));
    S2 = imadjust(histeq(rgb_result)); % histogram adjustment
    S2_t = S2 > 0.3; % procent n bagasah bvrt zurag ilvv tsewerhen bolson
 
    [~,threshold] = edge(S2_t,'sobel');
    fudgeFactor = 0.5;
    BWs = edge(S2_t,'sobel',threshold * fudgeFactor);
    se90 = strel('line',3,90);
    se0 = strel('line',5,0);
    BWsdil = imdilate(BWs,[se90 se0]);
    %BWdfill = imfill(BWsdil,'holes');
    %% on board
    %BWnobord = imclearborder(BWdfill,4);
    
    %% smooth
    seD = strel('diamond',1);
    BWfinal = imerode(BWsdil,seD);
    BWfinal = imerode(BWfinal,seD);

    %imshow(labeloverlay(image,BWfinal));
    
    title('Mask Over Original Image');
    %figure, montage({BWfinal}); % tresholding
    
    %S2_t, BWs, BWsdil, BWdfill, 

    BWoutline = bwperim(BWfinal);
    Segout = image; 
    Segout(BWoutline) = 25; 
    figure, imshow(Segout)
    title('Outlined Original Image')
    

