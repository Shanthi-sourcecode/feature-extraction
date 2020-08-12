clear all;
fe=[];
fe1=[];
combine=[];
srcFiles = dir('C:\Users\cudalab-001\Desktop\Sessions\anger\*.png');  % the folder in which ur images exists
for k = 1 : length(srcFiles)
filename = strcat('C:\Users\cudalab-001\Desktop\Sessions\anger\',srcFiles(k).name);
I2 =imread(filename);
if size(I2,3)==3
I2=rgb2gray(I2);
end
[m,n]=size(I2);
tic;
for i=2:m-1
for j=2:n-1
J0=I2(i,j);
        I3(i-1,j)=I2(i-1,j)>J0;
        I3(i-1,j+1)=I2(i-1,j+1)>J0; 
        I3(i,j+1)=I2(i,j+1)>J0;
        I3(i+1,j+1)=I2(i+1,j+1)>J0; 
        I3(i+1,j)=I2(i+1,j)>J0; 
        I3(i+1,j-1)=I2(i+1,j-1)>J0; 
        I3(i,j-1)=I2(i,j-1)>J0;
LBP(i,j)=uint8(I3(i-1,j+1)*2^7+I3(i-1,j)*2^6+I3(i-1,j-1)*2^5+I3(i,j-1)*2^4+I3(i+1,j-1)*2^3+I3(i+1,j)*2^2+I3(i+1,j+1)*2^1+I3(i,j+1)*2^0);
I4(i-1,j-1)= ~(xor(I2(i,j-1)>=I2(i-1,j-1), I2(i-1,j)>=I2(i-1,j-1)));
I4(i-1,j)= ~(xor(I2(i-1,j-1)>=I2(i-1,j),I2(i-1,j+1)>=I2(i-1,j)));
I4(i-1,j+1)=~(xor(I2(i-1,j)>=I2(i-1,j+1),I2(i,j+1)>=I2(i-1,j+1)));
I4(i,j-1)= ~(xor(I2(i-1,j-1)>=I2(i,j-1),I2(i+1,j-1)>=I2(i,j-1)));
I4(i,j+1)= ~(xor(I2(i-1,j+1)>=I2(i,j+1),I2(i+1,j+1)>=I2(i,j+1)));
I4(i+1,j-1)= ~(xor(I2(i,j-1)>=I2(i+1,j-1),I2(i+1,j)>=I2(i+1,j-1)));
I4(i+1,j)= ~(xor(I2(i+1,j-1)>=I2(i+1,j),I2(i+1,j+1)>=I2(i+1,j)));
I4(i+1,j+1)= ~(xor(I2(i+1,j)>=I2(i+1,j+1),I2(i,j+1)>=I2(i+1,j+1)));
LNEP(i,j)=uint8(I4(i-1,j+1)*2^7+I4(i-1,j)*2^6+I4(i-1,j-1)*2^5+I4(i,j-1)*2^4+I4(i+1,j-1)*2^3+I4(i+1,j)*2^2+I4(i+1,j+1)*2^1+I4(i,j+1)*2^0);
end
end
toc;
% imwrite(LBP,filename);
imshow(LBP),figure;
imshow(LNEP);
[pixelCounts, GLs] = imhist(LBP);
[pixelCounts1, GLs1] = imhist(LNEP);
fe=[fe;(pixelCounts/norm(pixelCounts))]';
fe1=[fe1;(pixelCounts1/norm(pixelCounts1))'];
combine=[fe,fe1];
end
%fe=[fe;(pixelCounts/norm(pixelCounts))'];
%end
