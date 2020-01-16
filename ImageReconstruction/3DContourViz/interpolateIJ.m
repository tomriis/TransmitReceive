function [x1, y1, x2, y2] = interpolateIJ(i,j,flipped_flag)
       if flipped_flag == 1
           iv = i; jv = j;
       else
           iv = j; jv = i;
       end
        [jv, idx] = unique(jv, 0);
        midpoint = mean(iv);
        iv = iv(idx);
        firstHalfInd = iv>midpoint;
        firstHalf = iv(firstHalfInd);
        secondHalfInd = iv<=midpoint;
        secondHalf = iv(secondHalfInd);
        q = linspace(min(jv),max(jv),2*range(jv));
        firstHalfq = round(interp1(jv(firstHalfInd), firstHalf,q,'spline'));
        secondHalfq = round(interp1(jv(secondHalfInd), secondHalf,q,'spline'));
        if flipped_flag == 1
            x1 = firstHalfq; y1 = round(q);
            x2 = secondHalfq; y2 = round(q); 
        else 
            y1 = firstHalfq; x1 = round(q);
            y2 = secondHalfq; x2 = round(q); 
        end
end