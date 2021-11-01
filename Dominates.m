

function b=Dominates(x,y)

 
    b=all(x<=y) && any(x<y);

end