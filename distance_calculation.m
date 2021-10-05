function [index_result, index_image_input] = distance_calculation(images_zigzag,num_results)
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
    cd ..;
    f = waitbar(0,'Calculating:','Name','Loading...');
    index_result = zeros(length(index_image_input),length(images_zigzag));
    w_Y = [0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    w_C = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
      
%     w_Y = [0 0 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
%     w_C = [1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
       
    for i = 1:length(index_image_input)
        %Extract histograms from "input.txt" images
        image_zigzag_input = images_zigzag{1,(index_image_input(i))}; 
        for j = 1: length(images_zigzag)
             
        index_result(i,j) = sqrt(sum(1*w_Y.*((image_zigzag_input(:,:,1) - images_zigzag{1,j}(:,:,1))).^2)) ...
            + sqrt(sum(32*w_C.*((image_zigzag_input(:,:,2) - images_zigzag{1,j}(:,:,2))).^2)) ....
            + sqrt(sum(64*w_C.*((image_zigzag_input(:,:,3) - images_zigzag{1,j}(:,:,3))).^2));
                
        end 
        [~,index_result(i,:)] = sort(index_result(i,:));      
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
    
    cd('Test');
%     %output =fopen('output.txt','w'); 
% 
%     %cd(test_path);
%     %output = uigetfile("*.txt");  
%     %Open output file
    output_text = fopen('output_CLD.txt', 'w');    
    %Write results
    for i = 1:length(index_image_input)
        for j = 1:num_results
            fprintf(output_text,'%s\n',sprintf('%04d', index_result(i,j) - 1));
        end
        fprintf(output_text,'\n');
    end
    %Close output file
    fclose(output_text);
    cd ..;
end