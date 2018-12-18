;; BEGIN HEADER

.class public fibonacci
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

  invokestatic fibonacci/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; int lo, hi, mx ;
  ;; lo = 1 ;
  ldc 1
  dup
  istore 0
  pop
  ;; hi = lo ;
  iload 0
  dup
  istore 1
  pop
  ;; mx = 5000000 ;
  ldc 5000000
  dup
  istore 2
  pop
  ;; printInt (lo);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; while (hi < mx)
  L0:
  ldc 1
  iload 1
  iload 2
  if_icmplt L2
  pop
  ldc 0
  L2:
  ifeq L1
  ;; printInt (hi);
  iload 1
  invokestatic Runtime/printInt(I)V
  ;; hi = lo + hi ;
  iload 0
  iload 1
  iadd
  dup
  istore 1
  pop
  ;; lo = hi - lo ;
  iload 1
  iload 0
  isub
  dup
  istore 0
  pop
  goto L0
  L1:
  ;; return 0 ;
  ldc 0
  ireturn
return
.end method
