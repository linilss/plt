all: lab4 test

lab4 : lab4.hs Interpreter.hs FUN/Test
	ghc --make lab4.hs -o lab4

test : test/const.hs
# test/dont-bind-too-eagerly.cc # scopes-reuse-name.cc # while-scope.cc  # if-scope.cc  # while-block.cc
	./lab4 -n $<

FUN/Test.hs FUN/Lex.x FUN/Layout.hs FUN/Par.y : FUN.cf
	bnfc --haskell -d $<

FUN/Par.hs: FUN/Par.y
	happy -gcai $<

FUN/Lex.hs: FUN/Lex.x
	alex -g $<

FUN/Test: FUN/Test.hs FUN/Par.hs FUN/Lex.hs
	ghc --make $< -o $@
	happy -gca FUN/ParFUN.y
	alex -g FUN/LexFUN.x
	ghc --make FUN/TestFUN.hs -o FUN/TestFUN

default: all

clean:
	-rm -f FUN/*.log FUN/*.aux FUN/*.hi FUN/*.o FUN/*.dvi

distclean: clean
	-rm -f FUN/DocFUN.* FUN/LexFUN.* FUN/ParFUN.* FUN/LayoutFUN.* FUN/SkelFUN.* FUN/PrintFUN.* FUN/TestFUN.* FUN/AbsFUN.* FUN/TestFUN FUN/ErrM.* FUN/SharedString.* FUN/ComposOp.* FUN/FUN.dtd FUN/XMLFUN.* Makefile*
		-rmdir -p FUN/

