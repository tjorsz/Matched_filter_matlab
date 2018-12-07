
pos_roi=image_labeler_input;
pos_dir=fullfile('F:\Test_Folder\Plane_test_positives')
%pos_dir = fullfile(matlabroot,'toolbox','vision','visiondata','Plane_test_positives');
addpath(pos_dir)

neg_dir = fullfile('F:\Test_Folder\Plane_test_negative_images');
addpath(neg_dir)

trainCascadeObjectDetector('trained_model_3.xml',pos_roi,neg_dir,'NumCascadeStages',20,'FeatureType','HOG','FalseAlarmRate', 0.2);


%fitcecoc -SVM classifier
%blockproc for sliding windows