function Dynamics = mfunc_GetDynamics(BasinNumber, Nmin)
% Get Dynamics
Num = length(BasinNumber);

% Frequency of staying each basin
Freq = zeros(1, Nmin);
for i=1:Nmin
   tmp = (BasinNumber == i);
   Freq(i) = sum(double(tmp)) / Num;
end

% Direct transition between basin
Dtrans = zeros(Nmin, Nmin);
for i=1:Nmin
    for j=1:Nmin
        if i==j
            continue;
        end
        cnt = 0;
        for t=1:Num-1
            if (BasinNumber(t) == i) && (BasinNumber(t+1) == j)
                cnt = cnt + 1;
            end
        end
        Dtrans(i,j) = cnt / Num;
    end
end

% Direct and indirect transition between basin
Trans = zeros(Nmin, Nmin);
for i=1:Nmin
    for j=1:Nmin
        if i==j
            continue;
        end
        ind_i = BasinNumber == i;
        ind_j = BasinNumber == j;
        cnt = 0;
       
        % Search next ind_i
        st_i = find(ind_i);
        if isempty(st_i)
            continue;
        end
        if st_i(1) >= Num
            continue;
        end
        
        st_j = find(ind_j);
        if isempty(st_j)
            continue;
        end
        if st_j(1) >= Num
            continue;
        end
        
        st_ii = st_i(1);
        while(true)
            tmp_j = find(st_j > st_ii, 1);
            if isempty(tmp_j)
                % End
                break;
            end
            % Found transition
            cnt = cnt + 1;
            % Search next i
            st_jj = st_j(tmp_j);
            tmp_i = find(st_i > st_jj, 1);
            if isempty(tmp_i)
                % End
                break;
            end
            st_ii = st_i(tmp_i);
        end
        
        Trans(i,j) = cnt / Num;
    end
end

% Set return value
Dynamics.Freq = Freq;
Dynamics.Dtrans = Dtrans;
Dynamics.Trans = Trans;






