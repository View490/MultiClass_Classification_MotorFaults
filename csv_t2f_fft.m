% note that this fucntion will; use the inputs as following statements:
% 1. filenames: the filepath with without the number at the end of filepath
% for exmaple, unbalance1P_600_
% 2. numfiles: this is the maimum of file numeber that wioll be attached
% with the filename to load the data to the worksapce
% 3. true/false:
% - vargin{1} this will plotting the figure fopr the whole
% dataset that loaded from this function
% - vargin{2} this is the title of the figure plotting usually be the
% fault type and the levle of serverity.
% Example :
% [matrix_f_data_misa_ang, matrix_t_data_misa_ang] = csv_t2f_fft( filenames, numfiles, true,"Misalignment Angular");


function [matrix_f_data, matrix_t_data] = csv_t2f_fft( filenames, numfiles, varargin)    
    matrix_tmp = zeros(50E3,3,numfiles*numel(filenames));
    matrix_t_data = zeros(50E3,3,numfiles*numel(filenames));
    n_notfound = 0;
    
    for i=1:length(filenames)
        for numfile=1:numfiles
            try
                filename = strcat(filenames(i),num2str(numfile),".csv");                
                dataset = csvread( ...
                    filename,5, ...
                    1);            
                matrix_tmp(:,:,numfile) = dataset(1:50E3,:);
            catch
                warning(strcat(filename, " not found numfile=",num2str(numfile)))
                n_notfound = n_notfound+1
            end
        end
        matrix_t_data(:,:,(i-1)*numfiles+1:i*numfiles) = matrix_tmp(:,:,1:numfiles);
    end
    
    Y=fft(matrix_t_data,[],1);
    P2 = abs(Y/size(Y,1));
    matrix_f_data = P2(1:size(Y,1)/2+1,:,:);
    matrix_f_data(2:end-1,:,:) = 2*matrix_f_data(2:end-1,:,:);
    matrix_f_data = matrix_f_data(2:end,:,:);    
    try
        if (varargin{1})
            figure; hold on;
            title(varargin{2});
            for idx=1:numfiles 
                plot(matrix_f_data(1:100,1,idx),'Color','b');
                plot(matrix_f_data(1:100,2,idx),'Color','g');
                plot(matrix_f_data(1:100,3,idx),'Color','r');
            end
            legend('v','h','a');
        end
    catch
    end
end