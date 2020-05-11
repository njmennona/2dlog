function RGBimage = im2RGB(image, cmap, I_low, I_high)
    image = double(image);
    numColors = size(cmap, 1);
    intIm = (image - I_low)/(I_high - I_low);
    intIm(intIm(:) < 0) = 0; 
    intIm(intIm(:) > 1) = 1;
    intIm = ceil(intIm*numColors);
    intIm(intIm(:) == 0) = 1;
    rIm = zeros(size(image));
    gIm = zeros(size(image));
    bIm = zeros(size(image));
    nanIdx = isnan(intIm); 
    intIm(nanIdx) = 1;
    rIm(:) = cmap(intIm, 1);
    gIm(:) = cmap(intIm, 2);
    bIm(:) = cmap(intIm, 3);
    rIm(nanIdx) = 1;
    gIm(nanIdx) = 1;
    bIm(nanIdx) = 1;
    RGBimage = cat(3, rIm, gIm, bIm);
end