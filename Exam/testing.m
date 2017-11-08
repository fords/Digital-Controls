filename = THexam_dataset1.txt;
fid = fopen(filename,'r');
time = textscan(fid,'HeaderLines',1);