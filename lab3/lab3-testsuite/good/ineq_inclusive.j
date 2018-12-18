;; BEGIN HEADER

.class public ineq_inclusive
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

  invokestatic ineq_inclusive/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; if (0 >= 0)
  ldc 1
  ldc 0
  ldc 0
  if_icmpge L2
  pop
  ldc 0
  L2:
  ifeq L0
  ;; printInt (0);
  ldc 0
  invokestatic Runtime/printInt(I)V
  goto L1
  L0:
  ;; printInt (1);
  ldc 1
  invokestatic Runtime/printInt(I)V
  L1:
  ;; if (1 >= 1)
  ldc 1
  ldc 1
  ldc 1
  if_icmpge L5
  pop
  ldc 0
  L5:
  ifeq L3
  ;; printInt (2);
  ldc 2
  invokestatic Runtime/printInt(I)V
  goto L4
  L3:
  ;; printInt (3);
  ldc 3
  invokestatic Runtime/printInt(I)V
  L4:
  ;; if (2 <= 2)
  ldc 1
  ldc 2
  ldc 2
  if_icmple L8
  pop
  ldc 0
  L8:
  ifeq L6
  ;; printInt (4);
  ldc 4
  invokestatic Runtime/printInt(I)V
  goto L7
  L6:
  ;; printInt (5);
  ldc 5
  invokestatic Runtime/printInt(I)V
  L7:
  ;; if (0 <= 0)
  ldc 1
  ldc 0
  ldc 0
  if_icmple L11
  pop
  ldc 0
  L11:
  ifeq L9
  ;; printInt (6);
  ldc 6
  invokestatic Runtime/printInt(I)V
  goto L10
  L9:
  ;; printInt (7);
  ldc 7
  invokestatic Runtime/printInt(I)V
  L10:
  ;; return 0 ;
  ldc 0
  ireturn
return
.end method
