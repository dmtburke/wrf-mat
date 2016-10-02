function [output] = showmatfiles(lonlat)
% Use geoshow to display the .mat files by their lat and long maps
% lonlat = [ lonMin lonMax latMin latMax ]
if ~exist('lonlat', 'var')
    disp('Using default US box, [-130 -70 20 60].');
    lonlat = [-130 -70 20 60];
else
    disp(['Using [' lonlat(1) ' ' lonlat(2) ' ' lonlat(3) ' ' lonlat(4)])
end

% [-130 -70 20 60]
%  lon  lon lat lat

d=dir('*.mat');d={d.name};
output = [];

for i=1:length(d)

    load(d{i});
    
    % These operate under the assumption that the biggest value will
    % always appear in the top left and the lowest in the bottom right
    upperLong = u.long(1);
    lowerLong = u.long(length(u.long));
    
    upperLat  = u.lat(1);
    lowerLat  = u.lat(length(u.lat));
    
    longinRange = lonlat(1) < upperLong && lonlat(2) > lowerLong;
    latinRange  = lonlat(3) < upperLat  && lonlat(4) > lowerLat;
    
    if longinRange && latinRange
        disp(['Drawing ' d{i} '...']);        
        geoshow(u.lat, u.long, u.data, cmapmod14)
        hold on
        
        output{length(output)+1} = d{i};
    else
        disp(['Skipping ' d{i} '...']);
    end
end
hold off
end