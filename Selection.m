function [Population,FrontNo,CrowdDis,ggg] = Selection(Population,N,zmin,zmax,k,a,G,Gmax)
% The  selection of NSGA-III*

    %% Normalization
     PopObj = Population.objs - repmat(zmin,length(Population),1);
     range  = zmax - zmin;
    if 0.05*max(range) < min(range)
     PopObj = PopObj./repmat(range,length(Population),1);
    end
    [~,x]      = unique(roundn(PopObj,-6),'rows');
    PopObj     = PopObj(x,:);
    Population = Population(x);
    N          = min(N,length(Population));
    
    %% Non-dominated sorting
    [FrontNo,MaxFNo] = NDSort_MSDR(PopObj,N,k,a,G,Gmax);
    Next = FrontNo < MaxFNo;
    ggg=size(find(FrontNo==1),2);
    %% Calculate the crowding distance of each solution
    CrowdDis = CrowdingDistance(PopObj,FrontNo);
    
    %% Select the solutions in the last front based on their crowding distances
    Last     = find(FrontNo==MaxFNo);
    [~,Rank] = sort(CrowdDis(Last),'descend');
    Next(Last(Rank(1:N-sum(Next)))) = true;
    
    %% Population for next generation
    Population = Population(Next);
    FrontNo    = FrontNo(Next);
    CrowdDis   = CrowdDis(Next);
end