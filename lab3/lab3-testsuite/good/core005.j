;; BEGIN HEADER

.class public core005
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

  invokestatic core005/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; int x ;
  ;; int y = 56 ;
  ldc 56
  istore 1
  ;; if (y + 45 <= 2)
  ldc 1
  iload 1
  ldc 45
  iadd
  ldc 2
  if_icmple L2
  pop
  ldc 0
  L2:
  ifeq L0
  ;; x = 1 ;
  ldc 1
  dup
  istore 0
  pop
  goto L1
  L0:
  ;; x = 2 ;
  ldc 2
  dup
  istore 0
  pop
  L1:
  ;; printInt (x);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; return 0 ;
  ldc 0
  ireturn
return
.end method
