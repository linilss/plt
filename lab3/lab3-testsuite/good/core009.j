;; BEGIN HEADER

.class public core009
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

  invokestatic core009/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; int x = foo () ;
  invokestatic core009/foo()I
  istore 0
  ;; printInt (x);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; return 0 ;
  ldc 0
  ireturn
return
.end method

.method public static foo()I
  .limit locals 100
  .limit stack  100
  ;; return 10 ;
  ldc 10
  ireturn
return
.end method
