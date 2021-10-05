function [mat_1] = alg1
    %fprintf("Select the folder where the image Database is located");
    %database_path = uigetdir();
    %cd(database_path);   
    cd('Database');
    database_path = pwd;
    %Exclusively .jpg format files
    image = dir(fullfile(database_path,'*.jpg'));                  
    ima = cell(1,length(image));                             
    %We create an array of empty cells
    mat_1 = ima;
    f = waitbar(0,'Calculating the image histograms...','Name','Loading...');
    fprintf("Calculating the image histograms...\n");
    %We go through all the jpg files in the directory
    for i = 1:length(image)         
        %Data in B / W. We convert the image name to a string
        ima{i} = rgb2gray(imread(sprintf(image(i).name))); 
        %Histogram. We put ~ because we are not interested with the map.
        [mat_1{i},~] = imhist(ima{i}, 127); 
        waitbar(i/length(image));
    end
    %We create the final matrix with the name of the images and their histogram value
    cd ..;
    delete(f);
end