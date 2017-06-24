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

%%%%%%%%%%%%%%%%%%% Stage 2
for k=1:length(cropped_faces)
crop_sizes(k)=size(cropped_faces(k,1).cropped_face,1);
disp(k)
end
smallest = min(crop_sizes);
% resize every picture to match smallest %
for j=1:num_pics
 ratio = smallest/crop_sizes(j);
 cropped_faces(j,1).cropped_face_shrunk = ....
 rgb2gray(imresize(cropped_faces(j,1).cropped_face, ...
 ratio,'method','bicubic','antialiasing',true));
 disp(j)
end


%%%%%%%%%%%%%%%%%%% Stage 3 Feature Extraction
bin = 8;
angle = 360;
L=2;
roi = [1;smallest;1;smallest];
for jjj=1:num_pics
 Im = cropped_faces(jjj,1).cropped_face_shrunk;
 p_temp=anna_phog(Im,bin,angle,L,roi);
cropped_faces(jjj,1).p = p_temp;
disp(jjj)
 clear p_temp
end

%%%%%%%%%%%%%%%%%%% Create Label
labels = [5, 3,	5,	1,	5,	5,	3,	1,	5,	2,	4,	4,	1,	2,	3,	2,	3,	1,	5,	2,	4,	3,	3,	1,	5,	2,	4,	1,	5,	4,	4,	1,	2,	4,	1,	5,	3,	3,	2,	5,	4,	1,	2,	4,	5,	4,	1,	5,	2,	2,	3,	3,	1];
% 1 = neutral, 2 = angry, 3 = surprised, 4 = sad, 5 = happy


%%%%%%%%%%%%%%%%%%% Create arff and save data
features = zeros(num_pics,length(cropped_faces(1,1).p));
for ii=1:num_pics
 features(ii,:)=cropped_faces(ii,1).p;
end
all_data = [features labels'];
arffwrite('kaiwen_zhong',all_data)

for i=1:num_pics
 my_feats(i,:)=cropped_faces(i,1).p;
end

save kaiwen_zhong my_feats labels