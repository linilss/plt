;; BEGIN HEADER

.class public test
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

  invokestatic test/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; int i = 1 ;
  ldc 1
  istore 0
  ;; int j = 0 ;
  ldc 0
  istore 1
  ;; if (true && true)
  ldc 0
  ldc 1
  ifeq L2
  ldc 1
  ifeq L2
  pop
  ldc 1
  L2:
  ifeq L0
  ;; printInt (i);
  iload 0
  invokestatic Runtime/printInt(I)V
  goto L1
  L0:
  ;; printInt (42);
  ldc 42
  invokestatic Runtime/printInt(I)V
  L1:
  ;; return 0 ;
  ldc 0
  ireturn
return
.end method
