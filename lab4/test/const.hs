--    -- File: good.hs
--
--    mult x y = if y < 1 then 0 else x + mult x (y-1) ;
--    fact     = \x -> if x < 3 then x else mult x (fact (x-1)) ;
	fac x = x + 3 ;
	grow = 1 ;
    main = print ( fac 1) ;