function [a, indexes] = makePseudoUnique(a, u_range)
    vals= unique(a); 
    indexes =[];
    for i = 1:length(vals)
        inds = find(a == vals(i));
        a(inds) = linspace(vals(i),vals(i)+u_range, length(inds));
        if u_range == 0
            indexes = horzcat(indexes, inds(randi(length(inds))));
            
        end
    end
    if u_range == 0
        a = vals;
    else
        indexes = 1:length(a);
    end
    
end