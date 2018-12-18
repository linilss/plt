;; BEGIN HEADER

.class public return_complex
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

  invokestatic return_complex/main()I
  pop
  return

.end method

;; END HEADER

.method public static foo(I)Z
  .limit locals 100
  .limit stack  100
  ;; if (x == 0)
  ldc 1
  iload 0
  ldc 0
  if_icmpeq L2
  pop
  ldc 0
  L2:
  ifeq L0
  ;; return false ;
  ldc 0
  ireturn
  goto L1
  L0:
  L1:
  ;; bool b = true ;
  ldc 1
  istore 1
  ;; printInt (x);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; return b ;
  iload 1
  ireturn
return
.end method

.method public static printBool(Z)V
  .limit locals 100
  .limit stack  100
  ;; if (false)
  ldc 0
  ifeq L3
  goto L4
  L3:
  ;; if (b)
  iload 0
  ifeq L5
  ;; printInt (0);
  ldc 0
  invokestatic Runtime/printInt(I)V
  goto L6
  L5:
  ;; printInt (1);
  ldc 1
  invokestatic Runtime/printInt(I)V
  L6:
  L4:
return
.end method

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; printBool (foo (42)) ;
  ldc 42
  invokestatic return_complex/foo(I)Z
  invokestatic return_complex/printBool(Z)V
  ;; printBool (foo (0)) ;
  ldc 0
  invokestatic return_complex/foo(I)Z
  invokestatic return_complex/printBool(Z)V
  ;; return 0 ;
  ldc 0
  ireturn
  ;; printBool (true);
  ldc 1
  invokestatic return_complex/printBool(Z)V
return
.end method
