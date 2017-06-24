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
%flip data
% l = all_group(2,1).labels;
% lflip = l';
% all_group(2,1).labels = lflip;
% l = all_group(3,1).labels;
% lflip = l';
% all_group(3,1).labels = lflip;

% LOSO

leave = 5;
train = [];
test = [];

for id = 1:5
    if id == leave
        f = all_group(id,1).features;
        l = all_group(id,1).labels;
        test = [f l'];
    else
        f = all_group(id,1).features;
        l = all_group(id,1).labels;
        train_id = [f l'];
        train = [train; train_id];
    end
end

arffwrite('test5', test);
arffwrite('train5', train);
