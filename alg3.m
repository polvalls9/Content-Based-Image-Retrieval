function [index_result, index_image_input] = alg3(mat_1,method, num_results)
    %path = pwd;
%     fprintf("Select the folder where the test file, input.txt and output.txt is located\n");
%     test_path = uigetdir();
%     cd(test_path);   
    cd('Test');
    %Open the "input.txt" file
    %fprintf("Select the input file\n");
    %input =fopen('input.txt');     
    input_text = fopen('input.txt');
    image_input_text = textscan(input_text,'%s','Delimiter','\n');
    fclose(input_text);
    %index_fotos_input is the list of indexes of the images in "input.txt"
    index_image_imput = cell(1,length(image_input_text));
    for i = 1:length(image_input_text{1,1})
        %The numbering of each photo starts at character number 8 and this length is 4
        index_image_imput{i} = 1 + str2double(image_input_text{1,1}{i}(end-8:end-4));       
    end
    index_image_input = cell2mat(index_image_imput);
    %Normalization of mat_1 histograms
    norm_histo = normc(mat_1(:));
    cd ..;
    f = waitbar(0,'Calculating:','Name','Loading...');
    index_result = zeros(length(index_image_input),length(norm_histo));
    for i = 1:length(index_image_input)
        %Extract histograms from "input.txt" images
        norm_histo_input = norm_histo(index_image_input(i)); 
        %Execute alg2
        aux = alg2(norm_histo, norm_histo_input, method, length(index_image_input));
        for j = 1: length(norm_histo)
            index_result(i,j) = aux(j);
        end
        waitbar(i/length(index_image_input));
    end
    delete(f);
    %Open the "output.txt" file
    %fprintf("Select the output file\n");
    %cd(test_path);  
    cd('Test');
    %output =fopen('output.txt','w'); 

    %cd(test_path);
    %output = uigetfile("*.txt");  
    %Open output file
    output_text = fopen('output.txt', 'w');    
    %Write results
    for i = 1:length(index_image_input)
        fprintf(output_text,'Retrieved list for query image %s \n',image_input_text{1,1}{i}); 
        for j = 1:num_results
            fprintf(output_text,'%s\n',sprintf('ukbench%05d.jpg', index_result(i,j) - 1));
        end
        fprintf(output_text,'\n');
    end
    %Close output file
    fclose(output_text);
    cd ..;
end