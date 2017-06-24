%%%%%%%%%%%%%%%%%%% Stage 1
faceDetector = vision.CascadeObjectDetector;
fnames = dir('*.JPG');
num_pics = length(fnames)

for i=1:num_pics
 fname = fnames(i,1).name;
 I = imread(fname);
 box1 = step(faceDetector,I);
 Ic = imcrop(I,box1);
 cropped_faces(i,1).cropped_face = Ic;
 disp(i)
 clear Ic I box1
end
