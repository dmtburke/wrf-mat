function output = firemaskinRange(u, lonlat)
% Determines if the firemask intersects the box given by lonlat
% Returns true if one of the 4 corners lands in lonlat

% TL = Top Left
% TR = Top Right
% BL = Bottom Left
% BR = Bottom Right

lonTL = u.long(1);
lonTR = u.long(size(u.long, 1),1);
lonBL = u.long(1,size(u.long,2));
lonBR = u.long(length(u.long));

latTL  = u.lat(1);
latTR  = u.lat(size(u.lat,1),1);
latBL  = u.lat(1, size(u.lat,2));
latBR  = u.lat(length(u.long));

lonTLinRange = lonTL > lonlat(1) && lonTL < lonlat(2);
lonTRinRange = lonTR > lonlat(1) && lonTR < lonlat(2);
lonBLinRange = lonBL > lonlat(1) && lonBL < lonlat(2);
lonBRinRange = lonBR > lonlat(1) && lonBR < lonlat(2);

latTLinRange = latTL > lonlat(3) && latTL < lonlat(4);
latTRinRange = latTR > lonlat(3) && latTR < lonlat(4);
latBLinRange = latBL > lonlat(3) && latBL < lonlat(4);
latBRinRange = latBR > lonlat(3) && latBR < lonlat(4);

TLinRange = lonTLinRange && latTLinRange;
TRinRange = lonTRinRange && latTRinRange;
BLinRange = lonBLinRange && latBLinRange;
BRinRange = lonBRinRange && latBRinRange;

output = TLinRange || TRinRange || BLinRange || BRinRange;
end
