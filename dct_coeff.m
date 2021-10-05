function [images_dct] = dct_coeff(images_partitioned)
    [~,N,M] = size(images_partitioned{1,1});
    images_dct = cell(1,length(images_partitioned));
    %Calculate the dct of each image
    for i = 1: length(images_partitioned)
        images_dct{1,i} = zeros(N,N,M,'double');
        for j = 1: 3
            images_dct{1,i}(:,:,j) = dct2(images_partitioned{1,i}(:,:,j));
        end
    end
end

