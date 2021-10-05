function [precision,recall] = alg4(num_results,index_image_input,index_result)
    true_samples = 4;
    precision = zeros(length(index_result(:,1)),num_results);
    recall = zeros(length(index_result(:,1)),num_results);
    for i = 1:length(index_result(:,1))
        correctly_detected = 0;
        for j = 1:num_results 
            if mod(index_image_input(i),true_samples) == 1
                for x = 0:true_samples
                    if(index_result(i,j)==index_image_input(i)+x)
                        correctly_detected = correctly_detected + 1;
                    end
                end
            elseif (mod(index_image_input(i),true_samples) > 1 ||...
                    mod(index_image_input(i),true_samples) < true_samples)
                if mod(index_image_input(i),2) == 0
                    for x = mod(index_image_input(i),true_samples)-true_samples+1 ...
                        :mod(index_image_input(i),true_samples)
                        if(index_result(i,j)==index_image_input(i)+x)
                            correctly_detected = correctly_detected + 1;
                        end
                    end    
                else
                    for x = mod(index_image_input(i),true_samples)-true_samples-1 ...
                        :-(mod(index_image_input(i),true_samples)-true_samples)
                        if(index_result(i,j)==index_image_input(i)+x)
                            correctly_detected = correctly_detected + 1;
                        end
                    end 
                end        
            elseif  mod(index_image_input(i),true_samples) == 0
                for x = -true_samples+1:0
                    if(index_result(i,j)==index_image_input(i)+x)
                        correctly_detected = correctly_detected + 1;
                    end
                end 
            end
            %Precision
            precision(i,j) = correctly_detected/j;
            %Recall
            recall(i,j) = correctly_detected/true_samples;
        end
    end
    precision = mean(precision);
    recall = mean(recall);
end