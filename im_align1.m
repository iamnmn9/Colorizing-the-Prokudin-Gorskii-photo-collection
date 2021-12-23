function [align_green, align_red] = im_align1(B,G,R,i)
    
    
    [hb,wb] = size(B);
    [hg,wg] = size(G);
    [hr,wr] = size(R);
    temp = inf;
    temp1 = inf;
    
    %%for image 3
    if i == 3
        window_B = B(10:300, 10:300);
        window_G = G(10:300, 10:300);
        window_R = R(10:300, 10:300);
        
        
    else
    
    %%%block window small
    
        window_B = B(ceil((hb/2))-50:ceil((hb/2))+50, ceil((wb/2))-50:ceil((wb/2))+50);
        window_G = G(ceil((hg/2))-50:ceil((hg/2))+50, ceil((wg/2))-50:ceil((wg/2))+50);
        window_R = R(ceil((hr/2))-50:ceil((hr/2))+50, ceil((wr/2))-50:ceil((wr/2))+50);    
    end
    %%%%%SSD
    for i = -15:15
        for j = -15:15
            ssd_B_G = sum(sum((window_B) - circshift((window_G),[i,j])).^ 2);
            if ssd_B_G < temp
                temp = ssd_B_G;
                g_row_shift = i;
                g_column_shift = j;
            end
        end
    end
    
    for i = -15:15
        for j = -15:15
            ssd_B_R = sum(sum((window_B)- circshift((window_R),[i,j])).^ 2);
            if ssd_B_R < temp1
                temp1 = ssd_B_R;
                r_row_shift = i;
                r_column_shift = j;
            end
        end
    end
    
    align_green = circshift(G,[g_row_shift,g_column_shift]);
    
    align_red = circshift(R,[r_row_shift,r_column_shift]);
    %disp('alignment in green image:')
    %align_green
    %disp('alignment in red image')
    %align_red
    
end