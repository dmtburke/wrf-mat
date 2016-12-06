function all2mat
% takes all active fire + geolocation HDFs in a directory and
% attempts to make them all into .mat files

%Convert MODIS files
d=dir(['MOD14','*.hdf']);d={d.name};
d=char(d);
nfiles = length(d);

for i=1:nfiles
    disp(['Converting ' d(i,:) '...']);
    modis2mat(d(i,:));
end

%Convert VIIRS files
d=dir(['VNP14','*.hdf']);d={d.name};
d=char(d);
nfiles = length(d);

for i=1:nfiles
    disp(['Converting ' d(i,:) '...']);
    viirs2mat(d(i,:));
end
end
