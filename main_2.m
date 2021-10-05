%clear
tic
num_results = 10;

%Execute partitioning
%images_partitioned = partitioning;
%Execute dct_coeff
images_dct = dct_coeff(images_partitioned);
%Execute quantizer
%images_dct_quant = quantizer(images_dct);
images_dct_quant = images_dct;
%Execute zigzag
images_zigzag = zigzag(images_dct_quant);
%Execute distance_calculation
[index_result, index_image_input] = distance_calculation_2(images_zigzag,num_results);
%Execute alg4
[precision,recall] = alg4(num_results,index_image_input,index_result);

%Precision & Recall curve
figure;
fig = plot(recall,precision,'-o');
title('Precision-Recall');
axis([0 1 0 1]);
xlabel('Recall');
ylabel('Precision');
%Compute fscore
fscore = (2*precision.*recall)./(precision+recall);
fscore = max(fscore);
legend_string = sprintf('CLD (F = %.4f)',fscore);
fig = legend(legend_string,'Location','southwest');
grid 'on';
cd('Results_PR');
%Save the Precision & Recall curve
saveas(fig,'CLD.png'); 
cd ..;

%Show time elapse in calculating a query image
fprintf("Time elapsed in calculating a query image: %.4f seconds\n", toc);
%Show the volume of all descriptors in the database
bytes_ws = struct2cell(whos);
bytes_total = 0;
for i = 1:length(size(bytes_ws{3,:}))
    bytes_total = bytes_total + bytes_ws{3,i};
end
fprintf("Volume of all descriptors in the database: %.4f MBytes\n",bytes_total/2^20)

%Show results
rep = input('Wanna see the results?[Y/N] ','s');
if(rep == 'Y' || rep == 'y')        
    cd('Database');
    for i = 1:length(index_result(:,1))
        f = figure;
        f.WindowState = 'maximized';
        queryimg = imread(sprintf('ukbench%05d.jpg', index_image_input(1,i)-1));
        resultimg1 = imread(sprintf('ukbench%05d.jpg', index_result(i,1)-1));
        resultimg2 = imread(sprintf('ukbench%05d.jpg', index_result(i,2)-1));
        resultimg3 = imread(sprintf('ukbench%05d.jpg', index_result(i,3)-1));
        resultimg4 = imread(sprintf('ukbench%05d.jpg', index_result(i,4)-1));
        resultimg5 = imread(sprintf('ukbench%05d.jpg', index_result(i,5)-1));
        resultimg6 = imread(sprintf('ukbench%05d.jpg', index_result(i,6)-1));
        resultimg7 = imread(sprintf('ukbench%05d.jpg', index_result(i,7)-1));
        resultimg8 = imread(sprintf('ukbench%05d.jpg', index_result(i,8)-1));
        resultimg9 = imread(sprintf('ukbench%05d.jpg', index_result(i,9)-1));
        resultimg10 = imread(sprintf('ukbench%05d.jpg', index_result(i,10)-1));
        subplot(353)
        imshow(queryimg);
        title('Query Image');
        xlabel(sprintf('ukbench%05d.jpg', index_image_input(1,i)-1));
        subplot(356)
        imshow(resultimg1);
        title('First Image');
        xlabel(sprintf('ukbench%05d.jpg', index_result(i,1)-1));
        subplot(357)
        imshow(resultimg2);
        title('Second Image');
        xlabel(sprintf('ukbench%05d.jpg', index_result(i,2)-1));
        subplot(358)
        imshow(resultimg3);
        title('Third Image');
        xlabel(sprintf('ukbench%05d.jpg', index_result(i,3)-1));
        subplot(359)
        imshow(resultimg4);
        title('Fourth Image');
        xlabel(sprintf('ukbench%05d.jpg', index_result(i,4)-1));
        subplot(3,5,10)
        imshow(resultimg5);
        title('Fifth Image');
        xlabel(sprintf('ukbench%05d.jpg', index_result(i,5)-1));
        subplot(3,5,11)
        imshow(resultimg6);
        title('Sixth Image');
        xlabel(sprintf('ukbench%05d.jpg', index_result(i,6)-1));
        subplot(3,5,12)
        imshow(resultimg7);
        title('Seventh Image');
        xlabel(sprintf('ukbench%05d.jpg', index_result(i,7)-1));
        subplot(3,5,13)
        imshow(resultimg8);
        title('Eitgh Image');
        xlabel(sprintf('ukbench%05d.jpg', index_result(i,8)-1));
        subplot(3,5,14)
        imshow(resultimg9);
        title('Ninth Image');
        xlabel(sprintf('ukbench%05d.jpg', index_result(i,9)-1));
        subplot(3,5,15)
        imshow(resultimg10);
        title('Tenth Image');
        xlabel(sprintf('ukbench%05d.jpg', index_result(i,10)-1));
    end
    cd ..;
end
fprintf("Bye!\n");