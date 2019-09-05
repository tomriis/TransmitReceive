function plot_unique(x)
    u_x = unique(x);
    matches = zeros([1,length(u_x)]);
    for i =1:length(u_x)
        matches(i)= sum(x == u_x(i));
    end
    plot(u_x, matches, 'b^');
end