function [align_green, align_red,align_blue] = im_align2(B,G,R,i)
        
    [hb,wb] = size(B);
    [hg,wg] = size(G);
    [hr,wr] = size(R);

    %%for image 3
    if i == 3
        window_B = B(10:300, 10:300);
        window_G = G(10:300, 10:300);
        window_R = R(10:300, 10:300);
        
    else  
        window_B = B(ceil((hb/2))-30:ceil((hb/2))+30, ceil((wb/2))-30:ceil((wb/2))+30);
        window_G = G(ceil((hg/2))-30:ceil((hg/2))+30, ceil((wg/2))-30:ceil((wg/2))+30);
        window_R = R(ceil((hr/2))-30:ceil((hr/2))+30, ceil((wr/2))-30:ceil((wr/2))+30);    
    end
    
    ncc = 0;
    for i = -15 : 15
        for j = -15 : 15
            %SHIFT by pixel 
            template = circshift(window_G, [i j]);
            shift_baseplate = circshift(window_B, [i j]);
            %mean of both windows
            mean_template = mean(template(:));
            mean_baseplate = mean(shift_baseplate(:));
            %ncc
            sum1 = sum((window_B - mean_baseplate).*(template - mean_template));
            sum2 = (sum((window_B - mean_baseplate).^2).*sum((template - mean_template).^2)).^0.5;
            temp_ncc = sum1 / sum2;
            
            if ncc < temp_ncc
                ncc = temp_ncc;
                max_ncc_BG = [i j];
            end    
        end
    end
    
    ncc = 0;
    for i = -15 : 15
        for j = -15 : 15
            template = circshift(window_R, [i j]);
            shift_baseplate = circshift(window_B, [i j]);
            mean_template = mean(template(:));
            mean_baseplate = mean(shift_baseplate(:));
            sum1 = sum((window_B - mean_baseplate).*(template - mean_template));
            sum2 = (sum((window_B - mean_baseplate).^2).*sum((template - mean_template).^2)).^0.5;
            temp_ncc = sum1 / sum2;
            if ncc < temp_ncc
                ncc = temp_ncc;
                max_ncc_BR = [i j];
            end    
        end
    end
    
        
    align_green = circshift(G,max_ncc_BG);
    align_red = circshift(R,max_ncc_BR);
    align_blue = B;
 
    
    
end    
 










