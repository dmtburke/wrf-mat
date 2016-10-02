function [output] = showmatfiles(lonlat)
% Use geoshow to display the .mat files by their lat and long maps
% lonlat = [ lonMin lonMax latMin latMax ]
if ~exist('lonlat', 'var')
    disp('Using default US box, [-130 -70 20 60].');
    lonlat = [-130 -70 20 60];
else
    disp(lonlat)
end

% [-130 -70 20 60]
%  lon  lon lat lat

d=dir('*.mat');d={d.name};
output = [];

for i=1:length(d)
    load(d{i});
    
    upperLong = max(u.long(:));
    lowerLong = min(u.long(:));
    
    if(upperLong - lowerLong > 180)
        upperLong = -180;
        lowerLong = 180;
    end
    
    upperLat  = max(u.lat(:));
    lowerLat  = min(u.lat(:));
    
    if upperLat - lowerLat > 180
        upperLat = -180;
        lowerLat = 180;
    end
   
    longinRange = lonlat(1) < upperLong && lonlat(2) > lowerLong;
    latinRange  = lonlat(3) < upperLat  && lonlat(4) > lowerLat;
    
    if longinRange && latinRange
        disp(['Drawing ' d{i} '...']);        
        geoshow(u.lat, u.long, u.data, cmapmod14)
        hold on
        
        output{length(output)+1} = [d{i} ', uLong: ' upperLong ', lLong: ' lowerLong ', uLat: ' upperLat ', lLat: ' lowerLat];
    else
        disp(['Skipping ' d{i} '...']);
    end
end
hold off
end