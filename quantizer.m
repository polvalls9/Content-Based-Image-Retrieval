function [images_dct_quant] = quantizer(images_dct)

    quantizer_luminance = [16 11 10 16 24 40 51 61
                        12 12 14 19 26 58 60 55
                        14 13 16 24 40 57 69 56
                        14 17 22 29 51 87 80 62
                        18 22 37 56 68 109 103 77
                        24 35 55 64 81 104 113 92
                        49 64 78 87 103 121 120 101
                        72 92 95 98 112 100 103 99];
                    
    quantizer_crominance = [17 18 24 47 99 99 99 99
                            18 21 26 66 99 99 99 99
                            24 26 56 99 99 99 99 99
                            47 66 99 99 99 99 99 99
                            99 99 99 99 99 99 99 99
                            99 99 99 99 99 99 99 99
                            99 99 99 99 99 99 99 99
                            99 99 99 99 99 99 99 99];

    images_dct_quant = images_dct;
    for n = 1: length(images_dct) 
        for i = 1:length(quantizer_luminance)
            for j = 1:length(quantizer_luminance)
                images_dct_quant{1,n}(i,j,1) = round(images_dct{1,n}(i,j,1)/quantizer_luminance(i,j));
                images_dct_quant{1,n}(i,j,2) = round(images_dct{1,n}(i,j,2)/quantizer_crominance(i,j));
                images_dct_quant{1,n}(i,j,3) = round(images_dct{1,n}(i,j,3)/quantizer_crominance(i,j));
            end
        end
    end
end

