;; BEGIN HEADER

.class public good15
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

  invokestatic good15/main()I
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
  ;; printInt (i);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; true || i ++ != 45 ;
  ldc 1
  ldc 1
  ifne L0
  ldc 1
  iload 0
  iload 0
  ldc 1
  iadd
  istore 0
  ldc 45
  if_icmpne L1
  pop
  ldc 0
  L1:
  ifne L0
  pop
  ldc 0
  L0:
  pop
  ;; printInt (i);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; false || i ++ >= 0 ;
  ldc 1
  ldc 0
  ifne L2
  ldc 1
  iload 0
  iload 0
  ldc 1
  iadd
  istore 0
  ldc 0
  if_icmpge L3
  pop
  ldc 0
  L3:
  ifne L2
  pop
  ldc 0
  L2:
  pop
  ;; printInt (i);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; true && i ++ < 0 ;
  ldc 0
  ldc 1
  ifeq L4
  ldc 1
  iload 0
  iload 0
  ldc 1
  iadd
  istore 0
  ldc 0
  if_icmplt L5
  pop
  ldc 0
  L5:
  ifeq L4
  pop
  ldc 1
  L4:
  pop
  ;; printInt (i);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; false && i ++ > 0 ;
  ldc 0
  ldc 0
  ifeq L6
  ldc 1
  iload 0
  iload 0
  ldc 1
  iadd
  istore 0
  ldc 0
  if_icmpgt L7
  pop
  ldc 0
  L7:
  ifeq L6
  pop
  ldc 1
  L6:
  pop
  ;; printInt (i);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; int j = 0 ;
  ldc 0
  istore 1
  ;; if (34 < 6 && j < 0)
  ldc 0
  ldc 1
  ldc 34
  ldc 6
  if_icmplt L11
  pop
  ldc 0
  L11:
  ifeq L10
  ldc 1
  iload 1
  ldc 0
  if_icmplt L12
  pop
  ldc 0
  L12:
  ifeq L10
  pop
  ldc 1
  L10:
  ifeq L8
  ;; printInt (i);
  iload 0
  invokestatic Runtime/printInt(I)V
  goto L9
  L8:
  ;; printInt (42);
  ldc 42
  invokestatic Runtime/printInt(I)V
  L9:
  ;; return 0 ;
  ldc 0
  ireturn
return
.end method
