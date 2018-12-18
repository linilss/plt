;; BEGIN HEADER

.class public good13
.super java/lang/Object

.method public <init>()V
  .limit locals 1

  aload_0
  invokespecial java/lang/Object/<init>()V
  return

.end method

.method public static main([Ljava/lang/String;)V
  .limit locals 1
  .limit stack  1

  invokestatic good13/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; int n, i ;
  ;; n = readInt () ;
  invokestatic Runtime/readInt()I
  dup
  istore 0
  pop
  ;; i = 2 ;
  ldc 2
  dup
  istore 1
  pop
  ;; while (i <= n)
  L0:
  ldc 1
  iload 1
  iload 0
  if_icmple L2
  pop
  ldc 0
  L2:
  ifeq L1
  ;; bool iPrime = true ;
  ldc 1
  istore 2
  ;; int j = 2 ;
  ldc 2
  istore 3
  ;; while (j * j <= i && iPrime)
  L3:
  ldc 0
  ldc 1
  iload 3
  iload 3
  imul
  iload 1
  if_icmple L6
  pop
  ldc 0
  L6:
  ifeq L5
  iload 2
  ifeq L5
  pop
  ldc 1
  L5:
  ifeq L4
  ;; if (i / j * j == i)
  ldc 1
  iload 1
  iload 3
  idiv
  iload 3
  imul
  iload 1
  if_icmpeq L9
  pop
  ldc 0
  L9:
  ifeq L7
  ;; iPrime = false ;
  ldc 0
  dup
  istore 2
  pop
  goto L8
  L7:
  L8:
  ;; j ++ ;
  iload 3
  iload 3
  ldc 1
  iadd
  istore 3
  pop
  goto L3
  L4:
  ;; if (iPrime && n / i * i == n)
  ldc 0
  iload 2
  ifeq L12
  ldc 1
  iload 0
  iload 1
  idiv
  iload 1
  imul
  iload 0
  if_icmpeq L13
  pop
  ldc 0
  L13:
  ifeq L12
  pop
  ldc 1
  L12:
  ifeq L10
  ;; printInt (i);
  iload 1
  invokestatic Runtime/printInt(I)V
  ;; n = n / i ;
  iload 0
  iload 1
  idiv
  dup
  istore 0
  pop
  goto L11
  L10:
  ;; i ++ ;
  iload 1
  iload 1
  ldc 1
  iadd
  istore 1
  pop
  L11:
  goto L0
  L1:
  ;; return 0 ;
  ldc 0
  ireturn
return
.end method
