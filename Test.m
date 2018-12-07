
video=VideoReader('3_Back_left_side.m4v');

Plane_detector= vision.CascadeObjectDetector('trained_model_3.xml');
while hasFrame(video)
    vf=readFrame(video);
    bbox=step(Plane_detector,vf);
    detectedImg = insertObjectAnnotation(vf, 'rectangle' , bbox, 'Match');
    imshow(detectedImg);
end