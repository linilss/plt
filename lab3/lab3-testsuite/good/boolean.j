;; BEGIN HEADER

.class public boolean
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

  invokestatic boolean/main()I
  pop
  return

.end method

;; END HEADER

.method public static ff()Z
  .limit locals 100
  .limit stack  100
  ;; printInt (0);
  ldc 0
  invokestatic Runtime/printInt(I)V
  ;; return false ;
  ldc 0
  ireturn
return
.end method

.method public static tt()Z
  .limit locals 100
  .limit stack  100
  ;; printInt (1);
  ldc 1
  invokestatic Runtime/printInt(I)V
  ;; return true ;
  ldc 1
  ireturn
return
.end method

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; bool t = true ;
  ldc 1
  istore 0
  ;; bool f = false ;
  ldc 0
  istore 1
  ;; bool silent1 = f && ff () ;
  ldc 0
  iload 1
  ifeq L0
  invokestatic boolean/ff()Z
  ifeq L0
  pop
  ldc 1
  L0:
  istore 2
  ;; bool silent2 = t || ff () ;
  ldc 1
  iload 0
  ifne L1
  invokestatic boolean/ff()Z
  ifne L1
  pop
  ldc 0
  L1:
  istore 3
  ;; bool noisy1 = t && tt () ;
  ldc 0
  iload 0
  ifeq L2
  invokestatic boolean/tt()Z
  ifeq L2
  pop
  ldc 1
  L2:
  istore 4
  ;; bool noisy2 = f || tt () ;
  ldc 1
  iload 1
  ifne L3
  invokestatic boolean/tt()Z
  ifne L3
  pop
  ldc 0
  L3:
  istore 5
  ;; return 0 ;
  ldc 0
  ireturn
return
.end method
