function vista_preprocessingProvide(pathToDTIs,pathToT1acpc)
% This function pre-processes DTI data according to the VistaSoft pipeline.
% You can enable/disable eddy correction depending on whether you ran this
% previously with FSL or dtiPrep. 
% Must input direct folder to DTI and T1 images.
% Assumes that inputs are labelled as 'prepped_eddy*' and 't1_acpc.nii.gz'.
% Contains flag for Siemens scanner.
% For questions, please contact theodore.turesky@childrens.harvard.edu


t1 = fullfile(pathToT1acpc,'t1_acpc.nii.gz');

nii = fullfile(pathToDTIs,'dtiprepped.nii.gz');
bvec = fullfile(pathToDTIs,'dtiprepped.bvec');
bval = fullfile(pathToDTIs,'dtiprepped.bval'); 

try
tempni = niftiRead(nii);
tempni.freq_dim = 1;
tempni.phase_dim = 2;
tempni.slice_dim = 3;

writeFileNifti(tempni);

tempdwParams = dtiInitParams('dt6BaseName','dtitrilin','phaseEncodeDir',2,'rotateBvecsWithCanXform',1,'bvecsFile', bvec,'bvalsFile',bval);
[tempdt6FileName, tempoutBaseDir] = dtiInit(nii,t1,tempdwParams);

clearvars tempni 

catch
    disp(['problem running ' pathToDTIs]);
end

clearvars nii bvec bval

end
  