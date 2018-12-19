grow x = 1 + grow x ;

first x y = x + 1 ;

main = print (first 4 (grow 4)) ; -- result 5 with -n, loop otherwise
