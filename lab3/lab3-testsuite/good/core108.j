;; BEGIN HEADER

.class public core108
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

  invokestatic core108/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; int j = 4 ;
  ldc 4
  istore 0
  ;; if (j < 6)
  ldc 1
  iload 0
  ldc 6
  if_icmplt L2
  pop
  ldc 0
  L2:
  ifeq L0
  ;; printInt (j);
  iload 0
  invokestatic Runtime/printInt(I)V
  goto L1
  L0:
  L1:
  ;; return j ;
  iload 0
  ireturn
return
.end method
