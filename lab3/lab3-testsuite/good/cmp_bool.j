;; BEGIN HEADER

.class public cmp_bool
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

  invokestatic cmp_bool/main()I
  pop
  return

.end method

;; END HEADER

.method public static printBool(Z)V
  .limit locals 100
  .limit stack  100
  ;; if (b)
  iload 0
  ifeq L0
  ;; printInt (1);
  ldc 1
  invokestatic Runtime/printInt(I)V
  goto L1
  L0:
  ;; printInt (0);
  ldc 0
  invokestatic Runtime/printInt(I)V
  L1:
return
.end method

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; printBool (true == true);
  ldc 1
  ldc 1
  ldc 1
  if_icmpeq L2
  pop
  ldc 0
  L2:
  invokestatic cmp_bool/printBool(Z)V
  ;; printBool (true == false);
  ldc 1
  ldc 1
  ldc 0
  if_icmpeq L3
  pop
  ldc 0
  L3:
  invokestatic cmp_bool/printBool(Z)V
  ;; printBool (true != false);
  ldc 1
  ldc 1
  ldc 0
  if_icmpne L4
  pop
  ldc 0
  L4:
  invokestatic cmp_bool/printBool(Z)V
  ;; return 0 ;
  ldc 0
  ireturn
return
.end method
