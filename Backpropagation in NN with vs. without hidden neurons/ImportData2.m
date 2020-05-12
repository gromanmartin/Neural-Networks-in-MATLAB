function [out] = ImportData2
    filename = 'valid_data_2017.txt';
    delimiterIn = '\t';
    headerlinesIn = 0;
    out = importdata(filename,delimiterIn,headerlinesIn);
end