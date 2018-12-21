all: lab4

lab4 : lab4.hs Interpreter.hs Fun/Test
	ghc --make lab4.hs -o lab4

test : test/const.hs
# test/dont-bind-too-eagerly.cc # scopes-reuse-name.cc # while-scope.cc  # if-scope.cc  # while-block.cc
	./lab4 -n $<


Fun/Test.hs Fun/Lex.x Fun/Layout.hs Fun/Par.y : Fun.cf
	bnfc --haskell -d $<

Fun/Par.hs: Fun/Par.y
	happy -gcai $<

Fun/Lex.hs: Fun/Lex.x
	alex -g $<

Fun/Test: Fun/Test.hs Fun/Par.hs Fun/Lex.hs
	ghc --make $< -o $@
	happy -gca Fun/Par.y
	alex -g Fun/Lex.x
	ghc --make Fun/Test.hs -o Fun/Test

default: all

clean:
	-rm -f Fun/*.log Fun/*.aux Fun/*.hi Fun/*.o Fun/*.dvi

distclean: clean
	-rm -f Fun/DocFun.* Fun/LexFun.* Fun/ParFun.* Fun/LayoutFun.* Fun/SkelFun.* Fun/PrintFun.* Fun/TestFun.* Fun/AbsFun.* Fun/TestFun Fun/ErrM.* Fun/SharedString.* Fun/ComposOp.* Fun/Fun.dtd Fun/XMLFun.* Makefile*
		-rmdir -p Fun/

