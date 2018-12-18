;; BEGIN HEADER

.class public core006
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

  invokestatic core006/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; int x, y ;
  ;; x = 45 ;
  ldc 45
  dup
  istore 0
  pop
  ;; y = 36 + 67 ;
  ldc 36
  ldc 67
  iadd
  dup
  istore 1
  pop
  ;; printInt (x);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; printInt (y);
  iload 1
  invokestatic Runtime/printInt(I)V
  ;; return 0 ;
  ldc 0
  ireturn
return
.end method
