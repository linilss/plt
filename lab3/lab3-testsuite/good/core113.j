;; BEGIN HEADER

.class public core113
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

  invokestatic core113/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; printInt (f (45)) ;
  ldc 45
  invokestatic core113/f(I)I
  invokestatic Runtime/printInt(I)V
  ;; printInt (f (450)) ;
  ldc 450
  invokestatic core113/f(I)I
  invokestatic Runtime/printInt(I)V
  ;; return 0 ;
  ldc 0
  ireturn
return
.end method

.method public static f(I)I
  .limit locals 100
  .limit stack  100
  ;; int y ;
  ;; if (x < 100)
  ldc 1
  iload 0
  ldc 100
  if_icmplt L2
  pop
  ldc 0
  L2:
  ifeq L0
  ;; int x = 91 ;
  ldc 91
  istore 2
  ;; y = x ;
  iload 2
  dup
  istore 1
  pop
  goto L1
  L0:
  ;; y = x ;
  iload 0
  dup
  istore 1
  pop
  L1:
  ;; return y ;
  iload 1
  ireturn
return
.end method
