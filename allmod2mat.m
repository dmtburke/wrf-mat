function allmod2mat(filenames)
%takes all mod14 files in a directory and attempts to make them all into
%.mat files
if ~exist('filenames', 'var')
    disp('Converting all files');
    filenames = dir(['MOD03','*.hdf']);
    filenames={filenames.name};
else
    disp('Using: ');
    disp(filenames);
end

for i=1:length(filenames)
    disp(['Converting ' filenames{i} '...']);
    mod2mat(filenames{i});
end
end
