function [a]=compute(G,Gmax)

    amax=60;
    dela=15;
    a=  amax-dela*(G/Gmax);
end