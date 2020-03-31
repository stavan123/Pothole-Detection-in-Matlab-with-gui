
    img = imread('G:\Stech\maat\potholes\potholes\pott.jpg');
   [imq,bound] = imgprocess(img); 
   figure;
   imshow(imq);
  display(bound);
 % baseFileName = 'my new image.png'; % Whatever....
%fullFileName = fullfile(someFolder, baseFileName);
%imwrite(rgbImage, fullFileName);

  
function [imgp,bound] = imgprocess(img)
%img = imgaussfilt(img,2);
%garbbing an image
%B = img;
[h,w] = size(img);
wratio = w/300;
hratio = h/400;
B =imresize(img, [400,300]); %resizing it
BC = imadjust(B,[0.3 0.7],[]);
G = rgb2gray(BC);   %converting it into gray
%psf = fspecial('motion',21,11);
%blured = imfilter(G, psf,'conv','circular');
Iblur = imgaussfilt(G,2);
%  BW = edge(G,'canny',0.6); %finding the edges
BW = edge(Iblur,'canny',0.6); %finding the edges
se = ones(30,30);
IM2 = imdilate(BW,se); %dilsting the image
subplot(4,2,1); %plotting orignal resized image
imshow(B);
title('Resized orignal image');
subplot(4,2,2);  %plotting edge detected image
imshow(BW);
title('Edge detection');
subplot(4,2,3);  %plotting dialated image
imshow(IM2);
subplot(4,2,4);
imshow(G);
title('Dialated image');
[L,num] = bwlabel(IM2);
bboxes = regionprops(IM2,'BoundingBox');
aTable = struct2table(bboxes);
%disp();
disp(aTable);
figure;
%imshow(BW);
imshow(B);
title("Bounding Box");
hold on;
for k = 1:length(bboxes)
   currbb = bboxes(k).BoundingBox;
    disp(currbb);
       %disp(temp);
   %currbb = bboxes.BoundingBox;
   %disp(currbb);
   area = currbb(3) * currbb(4);
   %if (area <= 00) 
   %  continue;
   %end  
  % disp(area);
   bound = area;
   %boundary = B{k};    imshow(bb);
   %rectangle('Position',[currbb(1)*wratio,currbb(2)*hratio,currbb(3),currbb(4)],'EdgeColor','r','LineWidth',2);
        rectangle('Position',[currbb(1),currbb(2),currbb(3),currbb(4)],'EdgeColor','r','LineWidth',2);
      
imgp = bound;
end
bb = insertShape(B,'rectangle',table2array(aTable),'LineWidth',2);
imshow(bb);
  hold off;  
  
end