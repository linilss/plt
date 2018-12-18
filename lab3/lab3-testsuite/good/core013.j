;; BEGIN HEADER

.class public core013
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

  invokestatic core013/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; printBool (test (0 - 1)&& test (0)) ;
  ldc 0
  ldc 0
  ldc 1
  isub
  invokestatic core013/test(I)Z
  ifeq L0
  ldc 0
  invokestatic core013/test(I)Z
  ifeq L0
  pop
  ldc 1
  L0:
  invokestatic core013/printBool(Z)V
  ;; printBool (test (0 - 2)|| test (1)) ;
  ldc 1
  ldc 0
  ldc 2
  isub
  invokestatic core013/test(I)Z
  ifne L1
  ldc 1
  invokestatic core013/test(I)Z
  ifne L1
  pop
  ldc 0
  L1:
  invokestatic core013/printBool(Z)V
  ;; printBool (test (3)&& test (0 - 5)&& true);
  ldc 0
  ldc 0
  ldc 3
  invokestatic core013/test(I)Z
  ifeq L3
  ldc 0
  ldc 5
  isub
  invokestatic core013/test(I)Z
  ifeq L3
  pop
  ldc 1
  L3:
  ifeq L2
  ldc 1
  ifeq L2
  pop
  ldc 1
  L2:
  invokestatic core013/printBool(Z)V
  ;; printBool (test (3)|| test (0 - 5)&& true);
  ldc 1
  ldc 3
  invokestatic core013/test(I)Z
  ifne L4
  ldc 0
  ldc 0
  ldc 5
  isub
  invokestatic core013/test(I)Z
  ifeq L5
  ldc 1
  ifeq L5
  pop
  ldc 1
  L5:
  ifne L4
  pop
  ldc 0
  L4:
  invokestatic core013/printBool(Z)V
  ;; printBool (true);
  ldc 1
  invokestatic core013/printBool(Z)V
  ;; printBool (false);
  ldc 0
  invokestatic core013/printBool(Z)V
  ;; return 0 ;
  ldc 0
  ireturn
return
.end method

.method public static printBool(Z)V
  .limit locals 100
  .limit stack  100
  ;; if (b)
  iload 0
  ifeq L6
  ;; printInt (1);
  ldc 1
  invokestatic Runtime/printInt(I)V
  goto L7
  L6:
  ;; printInt (0);
  ldc 0
  invokestatic Runtime/printInt(I)V
  L7:
return
.end method

.method public static test(I)Z
  .limit locals 100
  .limit stack  100
  ;; return i > 0 ;
  ldc 1
  iload 0
  ldc 0
  if_icmpgt L8
  pop
  ldc 0
  L8:
  ireturn
return
.end method
