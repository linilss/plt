;; BEGIN HEADER

.class public bool_return
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

  invokestatic bool_return/main()I
  pop
  return

.end method

;; END HEADER

.method public static c(I)Z
  .limit locals 100
  .limit stack  100
  ;; return d < d ;
  ldc 1
  iload 0
  iload 0
  if_icmplt L0
  pop
  ldc 0
  L0:
  ireturn
return
.end method

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; if (c (0))
  ldc 0
  invokestatic bool_return/c(I)Z
  ifeq L1
  ;; printInt (1);
  ldc 1
  invokestatic Runtime/printInt(I)V
  goto L2
  L1:
  ;; printInt (0);
  ldc 0
  invokestatic Runtime/printInt(I)V
  L2:
  ;; return 0 ;
  ldc 0
  ireturn
return
.end method
