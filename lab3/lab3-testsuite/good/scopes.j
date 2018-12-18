;; BEGIN HEADER

.class public scopes
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

  invokestatic scopes/main()I
  pop
  return

.end method

;; END HEADER

.method public static f()I
  .limit locals 100
  .limit stack  100
  ;; int n = 2 ;
  ldc 2
  istore 0
  ;; if (n < 3)
  ldc 1
  iload 0
  ldc 3
  if_icmplt L2
  pop
  ldc 0
  L2:
  ifeq L0
  ;; int n = 3 ;
  ldc 3
  istore 1
  ;; return n ;
  iload 1
  ireturn
  goto L1
  L0:
  L1:
  ;; return n ;
  iload 0
  ireturn
return
.end method

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; int n = 1 ;
  ldc 1
  istore 0
  ;; printInt (n);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; printInt (f ());
  invokestatic scopes/f()I
  invokestatic Runtime/printInt(I)V
  ;; printInt (n);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; return 0 ;
  ldc 0
  ireturn
return
.end method
