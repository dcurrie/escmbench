function fibonacci( n ) 
    if (n <= 1) then return n end
    return fibonacci(n - 2) + fibonacci(n - 1);
end

for i=0,33,1 do
    print( fibonacci(i) );
end
