%while 1: if current size hasn't been made yet, try most of them, then
%switch to a smaller more narrow model.

function  [current_sizing,guess_start_x,guess_start_y,detected] =guess_coordinates(empty_matrix,resized_images,new_sizes,current_sizing,x_len,y_len)
detected=false;
if current_sizing==0
    for i=1:1:length(new_sizes)
        %Find the normalized correlation of the signal image with the empty matrix
        c=normxcorr2(resized_images{i},empty_matrix);
        
        stop_condition=max(max(c));
        [x_peak, y_peak] = find(c==stop_condition);
        disp("stop_condition: ")
        disp(stop_condition)
    
        if stop_condition>.85
            current_sizing=i;
            %disp(x_peak-x_len)
            %disp(y_peak-y_len)
            break;
        end
    end
elseif current_sizing>0
    for i=(new_sizes(current_sizing)*ones(1,3))-[0,.125,-.125]
        image_num=find(i==new_sizes);
        %if ~isempty(image_num)
            c=normxcorr2(resized_images{image_num},empty_matrix);
            stop_condition=max(max(c));
            disp("stop condition: ")
            disp(stop_condition)
        
        
        if stop_condition>.85
            detected= true;
            [x_peak, y_peak] = find(c==stop_condition);
            %surf(c), shading flat
            current_sizing=find(i==new_sizes);
            disp("current sizing: ")
            disp(current_sizing)
            %disp(x_peak-x_len)
            %disp(y_peak-y_len)
            break;
        %end
        end
    end
end

guess_start_x=x_peak-x_len;
guess_start_y=y_peak-y_len;