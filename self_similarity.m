function output = self_similarity(input,varargin)
    output.data = input;
    if nargin > 1
        for i = 1:nargin-1
            option = varargin{i};
            switch option
                case 'l2'
                    output.l2 = euclidean_distance(input, input);
                case 'l1'
                    output.l1 = Manhattan(input, input);
                case 'cosine'
                    output.cosine = cosine_distance(input, input);
                case 'norm_minmax'
                    output.norm_minmax = norm_minmax(input);
                otherwise
                    error('Unknown option.');
            end    
        end
    else
        fprintf('please input the statistic options.')
    end
end