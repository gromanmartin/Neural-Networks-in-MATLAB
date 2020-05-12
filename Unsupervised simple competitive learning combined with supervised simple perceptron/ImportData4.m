function [out] = ImportData4
    filename = 'data_ex2_task3_2017.txt';
    delimiterIn = '\t';
    headerlinesIn = 0;
    out = importdata(filename,delimiterIn,headerlinesIn);
end