;; BEGIN HEADER

.class public good09
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

  invokestatic good09/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; int i = readInt () ;
  invokestatic Runtime/readInt()I
  istore 0
  ;; printInt (i);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; printInt (i ++);
  iload 0
  iload 0
  ldc 1
  iadd
  istore 0
  invokestatic Runtime/printInt(I)V
  ;; printInt (i);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; printInt (++ i);
  iload 0
  ldc 1
  iadd
  istore 0
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; printInt (i);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; return 0 ;
  ldc 0
  ireturn
return
.end method
