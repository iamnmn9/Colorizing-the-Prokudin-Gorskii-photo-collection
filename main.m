for i = 1:6
    raw_images = imread(strcat('image',int2str(i),'.jpg'));
    %%%imshow(raw_images)
    [h,w] = size(raw_images);
    %%disp(h)
    divide = h/3;
    %%BGR - images by dividing the whole image
    B_img = raw_images(1:divide, 1:w);
    G_img = raw_images(1+divide:divide+divide, 1:w);
    R_img = raw_images(1+divide+divide:divide+divide+divide, 1:w);  
    
    rgbimage(:,:,3)=B_img;

    rgbimage(:,:,2)=G_img;
    %%%first channel R 

    rgbimage(:,:,1)=R_img;
    %%blurred image direct concat
    %img_blur = cat(3,B_img, G_img, R_img);
    %imshow(B_img);
    imwrite(rgbimage, strcat('image',int2str(i),'-color.jpg'))
    %imshow(rgbimage)
    clear rgbimage
    
    
    
    
    %%%%%%%%%%%SSD%%%%%%%%%%%
    B_ssd_img = B_img;
    [G_ssd_img,R_ssd_img]  =  im_align1(B_img,G_img,R_img,i);
    rgb2image(:,:,3)=B_ssd_img;

    rgb2image(:,:,2)=G_ssd_img;

    rgb2image(:,:,1)=R_ssd_img;
    
    imwrite(rgb2image, strcat('image',int2str(i),'-ssd.jpg'))
    
    clear rgb2image

    %imshow(cat(3,B_ssd_img,G_ssd_img,R_ssd_img))
    
    
    
    %%%%%%%NCC
    
    %B_ncc_img = B_img;
    [G_ncc_img,R_ncc_img,B_ncc_img]  =  im_align2(B_img,G_img,R_img,i);
    rgb3image(:,:,3)=B_ncc_img;

    rgb3image(:,:,2)=G_ncc_img;

    rgb3image(:,:,1)=R_ncc_img;
    
    imwrite(rgb3image, strcat('image',int2str(i),'-ncc.jpg'))
    
    clear rgb3image
    
   
    
    
    

end