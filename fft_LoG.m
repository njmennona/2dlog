function prefAng = fft_LoG(filSig,numSig,numAngs,dtheta, filterThreshold,im)

    % Run on the image - FFT attempt

    % Create filter array
    [ix, iy] = meshgrid(-max(filSig)*numSig:max(filSig)*numSig, -max(filSig)*numSig:max(filSig)*numSig);
    filArray = zeros(size(ix, 1), size(ix, 2), numAngs);
    for i = 1:numAngs
        ang = dtheta + pi*i/numAngs;
        ix2 = cos(ang)*ix - sin(ang)*iy;
        iy2 = sin(ang)*ix + cos(ang)*iy;
        fil = MakeFil(ix2, iy2, filSig);
        fil = fil - sum(fil(:))/numel(fil);
        filArray(:, :, i) = fil;
    end
   
    filSize = size(filArray);


    % Create image array
    imArray = im;
    imSize = size(imArray);

    %%
    % Adjust filArray (based on size of image input)
    filArray = padarray(filArray, [imSize, 0] + 1, 'post');
    imArray = padarray(imArray, filSize(1:2) + 1, 'post');



    % Create FFTs
    fftImArray = fftn(imArray);
    fftFilArray = fftn(filArray);
    filIm = ifftn(fftImArray.*fftFilArray);
    filIm = filIm(((filSize(1) - 1)/2 + 1):(end - (filSize(1) - 1)/2), ((filSize(2) - 1)/2 + 1):(end - (filSize(2) - 1)/2), :);

    % See output
    % figure;
    % imagesc(max(real(filIm), [], 3));

    %% Process angles

    % Preferred angle mask
    % temp_filIm = filIm(:,:,1:90);

    mask = max(filIm, [], 3) > filterThreshold;
    [maxProjIm, prefAngIm] = max(filIm, [], 3);
    prefAng = prefAngIm;
    prefAng(~mask) = nan;
    prefAng = pi*(prefAng - 1)/numAngs;
    %edit May 3rd--remove boundary artifacts
    test = size(prefAng);
    prefAng(1:10,:,:)=NaN;
    prefAng(:,1:10,:)=NaN;
    prefAng(test(1)-10:test(1),:,:)=NaN;
    prefAng(:,test(1)-10:test(1),:)=NaN;

end