function [FrontNo,MaxFNo] = NDSort_MSDR(PopObj,nSort,k,a,G,Gmax)

%--------------------------------------------------------------------------

    N      = size(PopObj,1);
    NormP  = sum((PopObj).^k,2);                                % change here for MSDR
    cosine = 1 - pdist2(PopObj,PopObj,'cosine');
    cosine(logical(eye(length(cosine)))) = 0;
    Angle  = acos(cosine);
    temp  = sort((min(Angle,[],2)));                                          % change here for MSDR
    minA  =   temp(floor(a*N/100))  ;            % change here for MSDR
    Theta = max(1,(Angle./minA).^1);

    dominate = false(N);
    for i = 1 : N-1
        for j = i+1 : N
              if   NormP(i)*Theta(i,j) < NormP(j) || Dominates(PopObj(i,:),PopObj(j,:))==1
                    dominate(i,j) = true;
              elseif  NormP(j)*Theta(j,i) < NormP(i) || Dominates(PopObj(j,:),PopObj(i,:))==1
                    dominate(j,i) = true;
              end
        end
    end

    FrontNo = inf(1,N);
    MaxFNo  = 0;
    while sum(FrontNo~=inf) < min(nSort,N)
        MaxFNo  = MaxFNo + 1;
        current = ~any(dominate,1) & FrontNo==inf;
        FrontNo(current)    = MaxFNo;
        dominate(current,:) = false;
    end
end