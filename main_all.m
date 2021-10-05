fprintf("Methods:\n");
fprintf("[0: Correlation]\n[1: MSE]\n[2: MAE]\n[3: Battacharyya]\n");
fprintf("[4: Intersection]\n[5: SSIM]\n[6: Chi Square]\n");
fprintf("[7: KL (Kullback-Leibler)]\n[8: CDL]\n");
num_results = 10;
tic
%Execute alg1
[mat_1] = alg1;
f = figure;
%f.WindowState = 'maximized';
f.Position = [0 0 900 900];

for i = 0:7
    method = i;
    %Execute alg3
    [index_result,index_image_input] = alg3(mat_1,method, num_results);
    %Execute alg4
    [precision,recall] = alg4(num_results,index_image_input,index_result);
    %Precision & Recall curve
    %fig = plot(recall,precision,'-o');
    plot(recall,precision,'-o');
    hold all
    grid 'on';
    title('Precision-Recall');
    axis([0 1 0 1]);
    xlabel('Recall');
    ylabel('Precision');
    %Compute fscore
    fscore = (2*precision.*recall)./(precision+recall);
    fscore = max(fscore);
    switch method
        case 0
            %Correlation calculation
            legend_string = sprintf('Correlation (F = %.4f)',fscore);
        case 1
            %MSE calculation
            legend_string = sprintf('MSE (F = %.4f)',fscore);
        case 2
            %MAE calculation
            legend_string = sprintf('MAE (F = %.4f)',fscore);
        case 3
            %Battacharyya calculation
            legend_string = sprintf('Battacharyya (F = %.4f)',fscore);
        case 4
            %Intersection calculation
            legend_string = sprintf('Intersection (F = %.4f)',fscore);
        case 5
            %SSIM calculation
            legend_string = sprintf('SSIM (F = %.4f)',fscore);
        case 6
            %Chi Square calculation
            legend_string = sprintf('Chi-square (F = %.4f)',fscore);
        case 7
            %KL (Kullback-Leibler) calculation
            legend_string = sprintf('Kullback-Leibler (F = %.4f)',fscore);
    end
    legend_string_v(i+1) = cellstr(legend_string);
    %legend(legend_sring,'Location','southwest'); 
end

cd('Test');
output_text = fopen('output_CLD.txt');
image_output_text = textscan(output_text,'%s','Delimiter','\n');
fclose(output_text);
cd ..
index_result_output = (str2double(image_output_text{1,1}))';
x = 1;
y = 1;
for i = 1:length(index_result_output)
    if(isnan(index_result_output(1,i)))
        x = x + 1;
        y = 1;
    else
       index_result_CLD(x,y) = index_result_output(i)+1;
       y = y + 1;
    end
end
[precision,recall] = alg4(num_results,index_image_input,index_result_CLD);
fscore = (2*precision.*recall)./(precision+recall);
fscore = max(fscore);
legend_string_DCT = sprintf('CLD (F = %.4f)',fscore);
plot(recall,precision,'-o');


true_samples = 4;
precision_opt = ones(1,num_results);
recall_opt = ones(1,num_results);
recall_opt(1) = num_results/true_samples/10;
for i = 1:num_results
    if(i > true_samples)
        precision_opt(i) = precision_opt(i-1) - precision_opt(i-1)/i;
    elseif (i > 1 && i < true_samples)
       recall_opt(i) = recall_opt(i-1) + num_results/true_samples/10;
    end
end
fig = plot(recall_opt,precision_opt,'-d','Color',[0 0 0]); 
leg = legend(legend_string_v{1,1},legend_string_v{1,2},legend_string_v{1,3}, ...
    legend_string_v{1,4}, legend_string_v{1,5}, legend_string_v{1,6}, ...
    legend_string_v{1,7},legend_string_v{1,8},legend_string_DCT,'Optimal (F = 1)',...
    'FontSize',12,'Location','southwest');
hold off
cd('Results_PR');
%Save the Precision & Recall curve
saveas(fig,'All_methods.png'); 
cd ..;
fprintf("Done!\n");
%Show time elapse in calculating a query image
fprintf("Time elapsed in calculating a query image with all methods: %.4f seconds\n", toc);
%Show the volume of all descriptors in the database
bytes_ws = struct2cell(whos);
bytes_total = 0;
for i = 1:length(size(bytes_ws{3,:}))
    bytes_total = bytes_total + bytes_ws{3,i};
end
fprintf("Volume of all descriptors in the database: %.4f MBytes\n",bytes_total/2^20)
fprintf("Bye!\n");