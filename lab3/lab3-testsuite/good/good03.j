;; BEGIN HEADER

.class public good03
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

  invokestatic good03/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; int arg = readInt () ;
  invokestatic Runtime/readInt()I
  istore 0
  ;; int ret = 1 ;
  ldc 1
  istore 1
  ;; int i = 1 ;
  ldc 1
  istore 2
  ;; while (i < arg + 1)
  L0:
  ldc 1
  iload 2
  iload 0
  ldc 1
  iadd
  if_icmplt L2
  pop
  ldc 0
  L2:
  ifeq L1
  ;; ret = i * ret ;
  iload 2
  iload 1
  imul
  dup
  istore 1
  pop
  ;; ++ i ;
  iload 2
  ldc 1
  iadd
  istore 2
  iload 2
  pop
  goto L0
  L1:
  ;; printInt (ret);
  iload 1
  invokestatic Runtime/printInt(I)V
  ;; return 0 ;
  ldc 0
  ireturn
return
.end method
