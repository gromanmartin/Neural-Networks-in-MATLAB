function [out] = ImportData3
    filename = 'data_ex2_task2_2017.txt';
    delimiterIn = '\t';
    headerlinesIn = 0;
    out = importdata(filename,delimiterIn,headerlinesIn);
end