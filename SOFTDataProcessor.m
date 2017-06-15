function [geneNames,ExpressionData] = SOFTDataProcessor(fileName,numSamp,width)
%Function to process a .soft file given by fileName with numSamp number of
%samples.
%fileName ='GDS3572_full.soft';
%numSamp =6;
%width = 15;
%Output:
%   geneNames : cell array of the names of the genes in the file
%   ExpressionData: matrix of expression data where the columns repressent
%   the different samples and the rows the expression level for the gene
%   corresponding to that given in geneNames

SoftData = geosoftread(fileName);
geneNames = SoftData.Data(:,2);
ExpressionData = cell2mat(SoftData.Data(:,3:numSamp+2));
geneNames2 =  string();
condition = 1;
numAddP = 0;
numAdd = 0;


while(condition)
    for i =2:length(geneNames)
        if startsWith(geneNames(i-1),'PA') == 1 && max(startsWith(geneNames(i+1:i+width),'PA')) == 1 && startsWith(geneNames(i),'PA') ==0 
            temp = char(geneNames(i-1));
            %disp(temp(3:length(temp)))
            value = str2num(temp(3:length(temp)))+1;
            value = sprintf('%04d',value);
            geneNames2(i,1) = string(['P','A',value]); 
            numAdd = numAdd+1;
        else
            geneNames2(i,1) = string(geneNames(i));
        end

    end
    geneNames = cellstr(geneNames2);
    if(numAdd - numAddP == 0)
        condition = 0;
    end
    numAddP = numAdd;
    numAdd = 0;
end
end