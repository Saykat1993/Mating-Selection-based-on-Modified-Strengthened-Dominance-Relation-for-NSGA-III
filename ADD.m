function [Offspring] =ADD(Offspring,k)
        for i=1:length(Offspring)
            Offspring(i).add=k;
        end
end