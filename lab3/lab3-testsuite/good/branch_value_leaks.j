;; BEGIN HEADER

.class public branch_value_leaks
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

  invokestatic branch_value_leaks/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; int x0 = 0 ;
  ldc 0
  istore 0
  ;; if (false)
  ldc 0
  ifeq L0
  ;; 0 ;
  ldc 0
  pop
  goto L1
  L0:
  ;; bool x0 = true ;
  ldc 1
  istore 1
  L1:
  ;; int x1 = x0 -- ;
  iload 0
  iload 0
  ldc 1
  isub
  istore 0
  istore 2
  ;; return 0 ;
  ldc 0
  ireturn
return
.end method
