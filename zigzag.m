function [images_zigzag] = zigzag(images_dct)
    
    [~,N,M] = size(images_dct{1,1});
    images_zigzag = cell(1,length(images_dct));
    %Reordenate all dct images using ZigZag Zcanning Methoz
    for n = 1: length(images_dct) 
        images_zigzag{1,n} = zeros(1,N*N,M,'double');
        v = 1;
        for k = 1:2*N-1
            if k <= N
                if mod(k,2)==0
                    j = k;
                    for i = 1:k
                        images_zigzag{1,n}(1,v,:) = images_dct{1,n}(i,j,:);
                        v = v + 1;
                        j = j - 1;    
                    end
                else
                    i = k;
                    for j = 1:k   
                        images_zigzag{1,n}(1,v,:) = images_dct{1,n}(i,j,:);
                        v = v + 1;
                        i = i - 1; 
                    end
                end
            else
                if mod(k,2)==0
                    p = mod(k,N); 
                    j = N;
                    for i = p+1:N
                        images_zigzag{1,n}(1,v,:) = images_dct{1,n}(i,j,:);
                    v = v + 1;
                    j = j - 1;    
                    end
                else
                    p = mod(k,N);
                    i = N;
                    for j = p+1:N   
                        images_zigzag{1,n}(1,v,:) = images_dct{1,n}(i,j,:);
                        v = v + 1;
                        i = i - 1; 
                    end
                end
            end
        end
    end
end

