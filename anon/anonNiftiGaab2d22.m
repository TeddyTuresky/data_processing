addpath(genpath('/neuro/labs/gaablab/tools/vistasoft-master'));
addpath('/neuro/labs/gaablab/users/theodore.turesky');

C = importTextList('/neuro/labs/gaablab/users/theodore.turesky/nii4anon2d22.txt');


j = 0;
for i = 1:size(C,1)
    if isempty(strfind(C{i,1},'fa_color'))==1 && isempty(strfind(C{i,1},'FAColor'))==1
    try
        niftAnonVista(C{i,1})
    catch
        j = j + 1;
        m{j,1} = C{i,1};
    end
    end
end

save('/neuro/labs/gaablab/users/theodore.turesky/leftoverNifti2d22.mat','m');