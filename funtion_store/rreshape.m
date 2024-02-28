function Ans = rreshape(Matrix, A, B)
    % The reshape function provided by MATLAB operates in column order. In order to meet our code functionality requirements, 
    % we have redefined the reshape function to operate in row order.
    Size = size(Matrix);
    Ans = [];

    if Size(1) == 1
        if B == 1
            Ans = reshape(Matrix, A, B);
        elseif A == 1
            Ans = reshape(Matrix.', A, B);
        else
            Ans = reshape(Matrix, B, A).';
        end
    elseif Size(2) == 1
        if A == 1
            Ans = reshape(Matrix, A, B);
        elseif B == 1
            Ans = reshape(Matrix.', A, B);
        else
            Ans = reshape(Matrix, B, A).';
        end
    else
        if A==1 || B==1
            Ans = reshape(Matrix.', A, B);
        elseif Size(1)==A && Size(2)==B
            Ans = reshape(Matrix, A, B);
        else
            Ans = rreshape(Matrix, A*B, 1);
            Ans = rreshape(Ans, A, B);
        end
    end
end