function allmod2mat
%takes all mod14 files in a directory and attempts to make them all into
%.mat files

d=dir(['MOD14','*.hdf']);d={d.name};
d=char(d);
nfiles =    size(d,1);

for i=1:nfiles
    disp(['Converting ' d(i,:) '...']);
    mod2mat(d(i,:));
end
end
