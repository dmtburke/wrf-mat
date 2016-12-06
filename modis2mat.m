function modis2mat(mod14filename)
% Take data from a mod14 mod03 hdf pair and save to .mat, needs mod14
% filename as input.

str=regexp(mod14filename, '\.hdf' , 'match');

if (isempty(str))
    error('Passed a non-hdf file')
end

mod14date=char(regexp(mod14filename, 'A[0-9]+\.[0-9]+\.[0-9]+', 'match'));
mod03check= strcat('MOD03.', mod14date);

mod03filename=dir([mod03check '*.hdf']);

if(isempty(mod03filename))
    error('No matching MOD03 file');
end

mod03filename = mod03filename.name;

mod14DataPath = '/fire mask';
mod03LatPath  = '/MODIS_Swath_Type_GEO/Geolocation Fields/Latitude';
mod03LongPath = '/MODIS_Swath_Type_GEO/Geolocation Fields/Longitude';

u.data = hdfread(mod14filename, mod14DataPath);
u.lat  = hdfread(mod03filename, mod03LatPath);
u.long = hdfread(mod03filename, mod03LongPath);

u.conf = zeros(size(u.data), 'uint8');

fileinfo = hdfinfo(mod14filename);

% if the firepixels amount is 0 then move on with an all zero conf array
if(fileinfo.Attributes(1).Value ~= 0)
    
    mod14FPLatPath  = '/FP_latitude';
    mod14FPLongPath = '/FP_longitude';
    mod14FPConfPath = '/FP_confidence';
    
    confidence.lat  = hdfread(mod14filename, mod14FPLatPath);
    confidence.long = hdfread(mod14filename, mod14FPLongPath);
    confidence.conf = hdfread(mod14filename, mod14FPConfPath);

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
    
endfilename = strcat('MODIS', mod14date, '.mat');
u.title = endfilename;

save(endfilename, 'u');

end



