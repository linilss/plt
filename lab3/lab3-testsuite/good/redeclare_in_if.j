;; BEGIN HEADER

.class public redeclare_in_if
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

  invokestatic redeclare_in_if/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; int x0 = 32 ;
  ldc 32
  istore 0
  ;; if (0 < 0 - 0)
  ldc 1
  ldc 0
  ldc 0
  ldc 0
  isub
  if_icmplt L2
  pop
  ldc 0
  L2:
  ifeq L0
  ;; bool x0 = true ;
  ldc 1
  istore 1
  goto L1
  L0:
  ;; bool x0 = false ;
  ldc 0
  istore 2
  L1:
  ;; printInt (x0);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; return 0 ;
  ldc 0
  ireturn
return
.end method
