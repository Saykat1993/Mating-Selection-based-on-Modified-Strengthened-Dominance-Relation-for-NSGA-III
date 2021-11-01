function NSGAIII_MSDR(Global)
% <algorithm> <N>
% NSGAIII_MSDR/ NSGAIII*
% WRITTEN BY SAYKAT DUTTA

%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    %% Generate the reference points and random population
    [Z,Global.N] = UniformPoint(Global.N,Global.M);
    Population   = Global.Initialization();
    Zmin         = min(Population(all(Population.cons<=0,2)).objs,[],1);
    G=0;
    Gmax=Global.maxgen;
    [Population] =ADD(Population,0);
    k=[1.5,1,0.7,0.5,0.1];
    pr=[.20,.20,.20,.20,.20];
  %  a=60;
    %% Optimization
    while Global.NotTermination(Population)
            [a]=compute(G,Gmax);
            [~,FrontNo,CrowdDis,~] = Selection(Population,Global.N,min(Zmin, min(Population.objs,[],1)),max(Population.objs,[],1),k(1),a,G,Gmax);
            MatingPool1 = TournamentSelection(2,ceil((Global.N)*pr(1)),FrontNo,-CrowdDis);
            Offspring1  = GA(Population(MatingPool1));
            A=length(Offspring1);
            [Offspring1] =ADD( Offspring1,k(1));
            
            [~,FrontNo,CrowdDis,~] = Selection(Population,Global.N,min(Zmin, min(Population.objs,[],1)),max(Population.objs,[],1),k(2),a,G,Gmax);
            MatingPool2 = TournamentSelection(2,ceil((Global.N)*pr(2)),FrontNo,-CrowdDis);
            Offspring2  = GA(Population(MatingPool2));
            [Offspring2] =ADD( Offspring2,k(2));
            B=length(Offspring2);
            
            [~,FrontNo,CrowdDis,~] = Selection(Population,Global.N,min(Zmin, min(Population.objs,[],1)),max(Population.objs,[],1),k(3),a,G,Gmax);
            MatingPool3 = TournamentSelection(2,ceil((Global.N)*pr(3)),FrontNo,-CrowdDis);
            Offspring3  = GA(Population(MatingPool3));
            [Offspring3] =ADD( Offspring3,k(3));
            C=length(Offspring3);
            
            [~,FrontNo,CrowdDis,~] = Selection(Population,Global.N,min(Zmin, min(Population.objs,[],1)),max(Population.objs,[],1),k(4),a,G,Gmax);
            MatingPool4 = TournamentSelection(2,ceil((Global.N)*pr(4)),FrontNo,-CrowdDis);
            Offspring4  = GA(Population(MatingPool4));
            [Offspring4] =ADD( Offspring4,k(4));
            D=length(Offspring4);
            
            [~,FrontNo,CrowdDis,~] = Selection(Population,Global.N,min(Zmin, min(Population.objs,[],1)),max(Population.objs,[],1),k(5),a,G,Gmax);
            MatingPool5 = TournamentSelection(2,Global.N-(length(Offspring1)+length(Offspring2)+length(Offspring3)+length(Offspring4)),FrontNo,-CrowdDis);
            Offspring5  = GA(Population(MatingPool5));
            [Offspring5] =ADD( Offspring5,k(5));
            E=length(Offspring5);
            
            
            
            
            
            Offspring=[Offspring1,Offspring2,Offspring3,Offspring4,Offspring5];
            Zmin       = min([Zmin;Offspring(all(Offspring.cons<=0,2)).objs],[],1);
            G=G+1;
            Population = EnvironmentalSelection([Population,Offspring],Global.N,Z,Zmin);
            
            TT=Population.adds;
            
            a=size(find(TT==k(1)),1);
            b=size(find(TT==k(2)),1);
            c=size(find(TT==k(3)),1);
            d=size(find(TT==k(4)),1);
            e=size(find(TT==k(5)),1);
            a1=a/(a+b+c+d+e);
            b1=b/(a+b+c+d+e);
            c1=c/(a+b+c+d+e);
            d1=d/(a+b+c+d+e);
            e1=e/(a+b+c+d+e);
            S=[a1,b1,c1,d1,e1];
            pr=.7*pr+.3*S;
            pr=max(0.05,pr);
            pr=pr./sum(pr)

    end
end