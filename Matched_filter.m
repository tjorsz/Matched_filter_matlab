
%Take the initial photo, place it in the center of an empty array.
%Loop through the matrix in a sliding window fashion
%Take the correlation of the matrix.


%imshow --> black is 1, white is 0

%Create 2 instances of the plane image, convert the rgb data, then remove
%intensities
signal_image=ceil(rgb2gray(imread('Plane_1.jpg')));
subplot(2,1,1)
imshow(signal_image)

%Take the x,y size of the image, then create an empty matrix three times the image size and find where it  

[x_len,y_len]= size(signal_image);
empty_matrix = ones(x_len * 3 ,y_len *3);

%Place the image randomly in the picture

start_x=randi(x_len*2,1,1);
start_y=randi(y_len*2,1,1);
%starting_point=[start_x,start_y]
for i=1:x_len
   for j=1:y_len 
    empty_matrix(start_x+i,start_y+j)= signal_image(i,j);
    
   end 
end
subplot(2,1,2)
imshow(empty_matrix)
projected_image=ones(x_len,y_len);
tic;
while 1
    for i=1:2*x_len
        for j=1:2*y_len
            projected_image=empty_matrix(i:(x_len+(i-1)),j:(y_len+(j-1)));
            stop_condition=corr2(signal_image,projected_image)>.995;
            if stop_condition
                fprintf('start_x: %i , start_y: %i \n', start_x, start_y)
                fprintf('*match* @ x: %i , y: %i \n',(i-1), (j-1));
                toc
                break;
            end
 
        end
        
    end
    
end
 toc