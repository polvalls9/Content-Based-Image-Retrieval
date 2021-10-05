function [index_result] = alg2(norm_histo, norm_histo_input, method, num_image_input)
    mat_2 = cell(1,length(norm_histo));
    for j = 1:length(norm_histo)
        for i = 1:num_image_input
            histo_i = norm_histo(j);                  
            switch method
                case 0
                    %Correlation calculation
                    mat_2{i,j} = 1 - corr(norm_histo_input{i},histo_i{1}); 
                break;
                case 1
                    %MSE calculation
                    mat_2{i,j} = sum((norm_histo_input{i}-histo_i{1}).^2)/length(histo_i{1});  
                break;
                case 2
                    %MAE calculation
                    mat_2{i,j} = mean(abs(norm_histo_input{i}-histo_i{1})); 
                break;
                case 3
                    %Battacharyya calculation
                    mat_2{i,j} = 1 - sum((sqrt(norm_histo_input{i}.*histo_i{1}))./(sqrt(sum(norm_histo_input{i}).*sum(histo_i{1}))));
                break;
                case 4
                    %Intersection calculation
                    mat_2{i,j} = 1 - sum(min(norm_histo_input{i},histo_i{1}));
                break;
                case 5
                    %SSIM calculation
                    mat_2{i,j} = 1 - ssim(norm_histo_input{i},histo_i{1});
                break;
                case 6
                    %Chi Square calculation
                    aux = (norm_histo_input{i} - histo_i{1}).^2 ./(norm_histo_input{i} + histo_i{1});
                    aux(isnan(aux) | isinf(aux)) = 0;
                    mat_2{i,j} = sum(aux);
                break
                case 7
                    %KL (Kullback-Leibler) calculation
                    mat_2{i,j} = sum(abs((norm_histo_input{i}+1).*(log((norm_histo_input{i}+1)./(histo_i{1}+1)))));
                break;
            end
        end
    end
    %We get the resulting matrix of results, sorting this matrix to more similar to minus
    mat_2 = cell2mat(mat_2);
    [~,index_result] = sort(mat_2);
end