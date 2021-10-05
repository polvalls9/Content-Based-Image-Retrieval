clear
repeat = 1;
while(repeat > 0)
    fprintf("Methods:\n");
    fprintf("[0: Correlation]\n[1: MSE]\n[2: MAE]\n[3: Battacharyya]\n");
    fprintf("[4: Intersection]\n[5: SSIM]\n[6: Chi Square]\n");
    fprintf("[7: KL (Kullback-Leibler)]\n");
    method = input('Which method do you want to use? ');
    while(method < 0 || method > 7)
        method = input('Which method do you want to use?[0-7] ');
    end
    num_results = input('How many similar images do you want to get? ');
    while(num_results < 1 || num_results > 2000)
        num_results = input('How many similar images do you want to get?[1-2000] ');
    end
    tic
    if(repeat == 1)
        %Execute alg1
        [mat_1] = alg1;
    end
    %Execute alg3
    [index_result,index_image_input] = alg3(mat_1,method, num_results);
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
    switch method
        case 0
            %Correlation calculation
            legend_string = sprintf('Correlation (F = %.4f)',fscore);
            method_string = 'Correlation.png';
        case 1
            %MSE calculation
            legend_string = sprintf('MSE (F = %.4f)',fscore);
            method_string = 'MSE.png';
        case 2
            %MAE calculation
            legend_string = sprintf('MAE (F = %.4f)',fscore);
            method_string = 'MAE.png';
        case 3
            %Battacharyya calculation
            legend_string = sprintf('Battacharyya (F = %.4f)',fscore);
            method_string = 'Battacharyya.png';
        case 4
            %Intersection calculation
            legend_string = sprintf('Intersection (F = %.4f)',fscore);
            method_string = 'Intersection.png';
        case 5
            %SSIM calculation
            legend_string = sprintf('SSIM (F = %.4f)',fscore);
            method_string = 'SSIM.png';
        case 6
            %Chi Square calculation
            legend_string = sprintf('Chi-square (F = %.4f)',fscore);
            method_string = 'Chi_square.png';
        case 7
            %KL (Kullback-Leibler) calculation
            legend_string = sprintf('Kullback-Leibler (F = %.4f)',fscore);
            method_string = 'Kullback-Leibler.png';
    end
    legend(legend_string,'Location','southwest');
    grid 'on';
    cd('Results_PR');
    %Save the Precision & Recall curve
    saveas(fig,method_string); 
    cd ..;
    fprintf("Done!\n");
    %Show time elapse in calculating a query image
    fprintf("Time elapsed in calculating a query image: %.4f seconds\n", toc);
    %Show the volume of all descriptors in the database
    bytes_ws = struct2cell(whos);
    bytes_total = 0;
    for i = 1:length(size(bytes_ws{3,:}))
        bytes_total = bytes_total + bytes_ws{3,i};
    end
    fprintf("Volume of all descriptors in the database: %.4f MBytes\n",bytes_total/2^20)
    %Repeat with another method
    rep = input('Do you want to repeat with another method?[Y/N] ','s');
    if(rep == 'Y' || rep == 'y')
        repeat = repeat + 1;
    else
        repeat = 0;
    end
end
fprintf("Bye!\n");