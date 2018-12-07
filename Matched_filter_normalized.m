%Implementation of a matched filter using the normalized cross-correlation

%Create 2 instances of the plane image, convert the rgb data, then remove
%intensities
signal_image=(rgb2gray(imread('Plane_2_1.jpg')));
%subplot(2,1,1)
%imshow(signal_image)

%Take the x,y size of the image, then create an empty matrix three times the image size and find where it  

[x_len,y_len]= size(signal_image);

%Different sizes
new_sizes=.5:.125:2.5;
resized_images=cell(1,length(new_sizes));
for i=1:length(new_sizes)
    resized_images{i}=imresize(signal_image,new_sizes(i));
end

resized_images{7}=(rgb2gray(imread('Plane_1_s7.jpg')));
resized_images{8}=(rgb2gray(imread('Plane_1_s8.jpg')));
resized_images{9}=(rgb2gray(imread('Plane_1_s9.jpg')));
resized_images{10}=(rgb2gray(imread('Plane_1_s10.jpg')));
resized_images{11}=(rgb2gray(imread('Plane_1_s11.jpg')));
resized_images{12}=(rgb2gray(imread('Plane_1_s12.jpg')));
resized_images{13}=(rgb2gray(imread('Plane_1_s13.jpg')));
resized_images{14}=(rgb2gray(imread('Plane_1_s14.jpg')));


video = VideoReader('5_Front.m4v');
current_sizing=0;

video_write=VideoWriter('video.avi');
open(video_write);
while hasFrame(video)
    video_frame=rgb2gray(readFrame(video));
    [current_sizing,guess_start_x,guess_start_y,detected]=guess_coordinates(video_frame,resized_images,new_sizes,current_sizing,x_len,y_len);
    figure
    if detected
    
        %imrect(gca, [guess_start_y+1, guess_start_x+1, size(resized_images{current_sizing},2), size(resized_images{current_sizing},1)])
        %imrect(gca, [guess_start_y+1, guess_start_x+1,10 ,10])
        video_frame = insertObjectAnnotation(video_frame, 'rectangle' , [guess_start_y+1, guess_start_x+1, size(signal_image,2), size(signal_image,1)], 'Match');
    
    end
    imshow(video_frame);
    writeVideo(video_write,video_frame)
end
close(video_write)

