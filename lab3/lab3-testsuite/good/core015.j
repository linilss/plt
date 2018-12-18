;; BEGIN HEADER

.class public core015
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

  invokestatic core015/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; printInt (ev (17)) ;
  ldc 17
  invokestatic core015/ev(I)I
  invokestatic Runtime/printInt(I)V
  ;; return 0 ;
  ldc 0
  ireturn
return
.end method

.method public static ev(I)I
  .limit locals 100
  .limit stack  100
  ;; int e ;
  ;; if (y > 0)
  ldc 1
  iload 0
  ldc 0
  if_icmpgt L2
  pop
  ldc 0
  L2:
  ifeq L0
  ;; e = ev (y - 2);
  iload 0
  ldc 2
  isub
  invokestatic core015/ev(I)I
  dup
  istore 1
  pop
  goto L1
  L0:
  ;; if (y < 0)
  ldc 1
  iload 0
  ldc 0
  if_icmplt L5
  pop
  ldc 0
  L5:
  ifeq L3
  ;; e = 0 ;
  ldc 0
  dup
  istore 1
  pop
  goto L4
  L3:
  ;; e = 1 ;
  ldc 1
  dup
  istore 1
  pop
  L4:
  L1:
  ;; return e ;
  iload 1
  ireturn
return
.end method
