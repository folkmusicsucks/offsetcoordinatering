%Prepare environment.
close all
clear

%Earth's radius.
%Can be any unit but offset distance must be the same unit.
RadiusEarth=6371000;

%Prompt for initial coordinates, offset distance and bearing.
prompt={"Object latitude","Object longitude","Offset bearing","Offset distance"};
defaults = {"60.456371", "22.214298", "35", "300"};
answer=inputdlg(prompt,"Enter location and offsets",1,defaults);

%Convert degrees to radians and populate initial variables.
lat1=deg2rad(str2num(answer{1}));
lon1=deg2rad(str2num(answer{2}));

%Populate offset variables.
offbear=deg2rad(str2num(answer{3}));
offdist=str2num(answer{4});

%Print coordinates of initial value.
printf("Initial coordinates: %5.10d, %5.10d\n", rad2deg(lat1), rad2deg(lon1));

%%File handling is temporary. In for loop uncomment fprintf when writing to file.
%Open a file to save offset coordinates to.
file_id = fopen('text1.txt', 'w');
%print initial coordinates and offset distance to file.
fprintf(file_id, "Initial coordinates: %5.10d, %5.10d\nOffset distance: %d\n\n", rad2deg(lat1), rad2deg(lon1), offdist);

%for loop to list offsets for 360 degrees at 10 degree increments.
for count=0:10:350
%Calculate lat and long for 10 degree incremented values.
%https://www.movable-type.co.uk/scripts/latlong.html
%https://www.edwilliams.org/avform147.htm#LL
  lat2=asin(sin(lat1)*cos(offdist/RadiusEarth)+cos(lat1)*sin(offdist/RadiusEarth)*cos(deg2rad(count)));
  lon2=lon1+atan2(sin(deg2rad(count))*sin(offdist/RadiusEarth)*cos(lat1),cos(offdist/RadiusEarth)-sin(lat1)*sin(lat2));
%Print degrees and coordinates. fprintf for file handling.
  printf("Degrees: %d - Coordinates: %5.10d, %5.10d\n", count, rad2deg(lat2), rad2deg(lon2));
  fprintf(file_id, "Degrees: %d - Coordinates: %5.10d, %5.10d\n", count, rad2deg(lat2), rad2deg(lon2));
end

%Calculate lat and long for entered values.
%https://www.movable-type.co.uk/scripts/latlong.html
%https://www.edwilliams.org/avform147.htm#LL
lat2=asin(sin(lat1)*cos(offdist/RadiusEarth)+cos(lat1)*sin(offdist/RadiusEarth)*cos(offbear));
lon2=lon1+atan2(sin(offbear)*sin(offdist/RadiusEarth)*cos(lat1),cos(offdist/RadiusEarth)-sin(lat1)*sin(lat2));

%Print coordinates for entered values.
printf("\nCoordinates: %5.10d, %5.10d\n", rad2deg(lat2), rad2deg(lon2));

%Close file. No more file handling after this.
fclose(file_id);

%Plot coordinates for sanity check.
%t = 0:10:350;
%scatter (rad2deg(asin(sin(lat1)*cos(offdist/RadiusEarth)+cos(lat1)*sin(offdist/RadiusEarth)*cos(deg2rad(t)))), rad2deg(lon1+atan2(sin(deg2rad(t))*sin(offdist/RadiusEarth)*cos(lat1),cos(offdist/RadiusEarth)-sin(lat1)*sin(lat2))), "+k");
%plot(rad2deg(lon1),rad2deg(lat1));
%plot(rad2deg(lon2),rad2deg(lat2));
