% load('s1.mat')
% all_group(1,1).features = my_feats;
% all_group(1,1).labels = labels;
% all_group(1,1).id = 1;
% 
% load('s2.mat')
% all_group(2,1).features = my_feats;
% all_group(2,1).labels = labels;
% all_group(2,1).id = 1;
% 
% load('s3.mat')
% all_group(3,1).features = my_feats;
% all_group(3,1).labels = labels;
% all_group(3,1).id = 1;
% 
% load('s4.mat')
% all_group(4,1).features = my_feats;
% all_group(4,1).labels = labels;
% all_group(4,1).id = 1;
% 
% load('kaiwen_zhong.mat')
% all_group(5,1).features = my_feats;
% all_group(5,1).labels = labels;
% all_group(5,1).id = 1;
% 
% %flip data
% l = all_group(2,1).labels;
% lflip = l';
% all_group(2,1).labels = lflip;
% 
% l = all_group(2,1).labels;
% lflip = l';
% all_group(2,1).labels = lflip;

neutral = 1;

data = [];

for id = 1:5
    f = all_group(id,1).features;
    l = all_group(id,1).labels;
    l_neutral_ind = find(l==neutral);
    f_neutral = f(l_neutral_ind, :);
    
    [col, row] = size(l_neutral_ind);
    ids = ones(1,row)*id;
    
    data_id = [f_neutral ids'];
    data = [data; data_id];
end

arffwrite('person_id', data);

