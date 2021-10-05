function [images_partitioned] = partitioning
     
    cd('Database');
    database_path = pwd;
    %Exclusively .jpg format files
    image = dir(fullfile(database_path,'*.jpg'));                  
    ima = cell(1,length(image));                             
    images_partitioned = ima;
    f = waitbar(0,'Partitioning all images to 8x8 blocks...','Name','Partitioning...');
    fprintf("Partitioning all images to 8x8 blocks...\n");
    %We go through all the jpg files in the directory
    for i = 1:length(image)         
        %Partitioning to 8x8 | 64 Blocks
        ima{i} = imread(sprintf(image(i).name)); 
        ima{i} = double(rgb2ycbcr(ima{i}));
        ima{i} = imresize(ima{i}, [8 8]);
        images_partitioned(i) = mat2cell(ima{i},8*ones(1,size(ima{i},1)/8),8*ones(1,size(ima{i},2)/8),3);
        waitbar(i/length(image));
    end
    cd ..;
    delete(f);
end