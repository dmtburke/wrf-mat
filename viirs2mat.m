function viirs2mat(vnp14filename)
% Take data from a vnp14/IMFTS hdf pair and save to .mat, needs vnp14
% filename as input.

str=regexp(vnp14filename, '\.hdf' , 'match');

if (isempty(str))
    error('Passed a non-hdf file')
end

vnp14date=char(regexp(vnp14filename, 'A[0-9]+\.[0-9]+\.[0-9]+', 'match'));
IMFTScheck= strcat('NPP_IMFTS_L1.', vnp14date);

IMFTSfilename=dir([IMFTScheck '*.hdf']);

if(isempty(IMFTSfilename))
    error('No matching IMFTS file');
end

IMFTSfilename = IMFTSfilename.name;

vnp14DataPath = '/fire mask';
IMFTSLatPath  = '/VIIRS_TC_GEOLOCATION_375m/Geolocation Fields/Latitude';
IMFTSLongPath = '/VIIRS_TC_GEOLOCATION_375m/Geolocation Fields/Longitude';

u.data = hdfread(vnp14filename, vnp14DataPath);
% TODO Convert the values in the viirs firemask to match the modis firemask
% values
u.lat  = hdfread(IMFTSfilename, IMFTSLatPath);
u.long = hdfread(IMFTSfilename, IMFTSLongPath);

u.conf = zeros(size(u.data), 'uint8');

fileinfo = hdfinfo(vnp14filename);

% if the firepixels amount is 0 then move on with an all zero conf array
if(fileinfo.Attributes(16).Value ~= 0)
    
    vnp14FPLatPath  = '/FP_latitude';
    vnp14FPLongPath = '/FP_longitude';
    vnp14FPConfPath = '/FP_confidence';
    
    confidence.lat  = hdfread(vnp14filename, vnp14FPLatPath);
    confidence.long = hdfread(vnp14filename, vnp14FPLongPath);
    confidence.conf = hdfread(vnp14filename, vnp14FPConfPath);

    % Find indices of u.lat which match data in confidence.lat
    indexLat  = find(ismember(u.lat , confidence.lat));
    indexLong = find(ismember(u.long, confidence.long));
    
    % Find the matching indices of indexLat and indexLong
    % These are going to be the indices in u.data which 
    % correspond to the confidence data
    indexConf  = indexLat(ismember(indexLat, indexLong));

    % Use the data from before to put confidence data in the correct place
    % in the u.conf array
    for i = 1:size(indexConf)
        u.conf(indexConf(i)) = confidence.conf(i);
    end
end
    
endfilename = strcat('VIIRS.', vnp14date, '.mat');
u.title = endfilename;

save(endfilename, 'u');

end