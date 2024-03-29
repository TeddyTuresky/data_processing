
clear all; close all; clc
cd /Users/doggybot/Documents/MotorAnalysis/processing

n_img = 65; % number of images to be transformed
hand = ['L';'R']; 
group = ['a';'c'];


for h = 1:length(hand);
    hand1 = hand(h);
    for g = 1:length(group);
        group1 = group(g);
        if group1 == 'a';
            long = 'adults';
            subj = ['01';'02';'03';'04';'05';'06';'07';'08'; '09';'10';'11';
                '12';'13';'14';'15';'16';'17']; 
        else
            long = 'children';
            subj = ['01';'02';'03';'04';'05';'06';'07';'08'; '09';'10';'11';
                '12';'13';'14';'15';'16';'17';'18';'19';'20';'21';'22';'23'];
        end
        
        load(['5Deform-' group(1) '01' hand(1) '.mat']);
        matlabbatch = repmat(matlabbatch,1,(length(subj)));

        for j = 1:length(subj);
            matlabbatch{1,j}.spm.util.defs.comp{1,1}.def{1,1} = strrep(matlabbatch{1,j}.spm.util.defs.comp{1,1}.def{1,1},'adults',long);
            matlabbatch{1,j}.spm.util.defs.comp{1,1}.def{1,1} = strrep(matlabbatch{1,j}.spm.util.defs.comp{1,1}.def{1,1},'a01',[group1 subj(j,:)]);
            for i = 1:n_img
                matlabbatch{1,j}.spm.util.defs.out{1,1}.pull.fnames{i,1} = strrep(matlabbatch{1,j}.spm.util.defs.out{1,1}.pull.fnames{i,1},'adults',long);
                matlabbatch{1,j}.spm.util.defs.out{1,1}.pull.fnames{i,1} = strrep(matlabbatch{1,j}.spm.util.defs.out{1,1}.pull.fnames{i,1},'a01',[group1 subj(j,:)]);
                matlabbatch{1,j}.spm.util.defs.out{1,1}.pull.fnames{i,1} = strrep(matlabbatch{1,j}.spm.util.defs.out{1,1}.pull.fnames{i,1},'motorL',['motor' hand1]);  
             end
        end

        save(['5Deform_' group1 hand1 '.mat'],'matlabbatch')
        clearvars matlabbatch subj

    end
end