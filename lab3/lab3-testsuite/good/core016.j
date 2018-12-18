;; BEGIN HEADER

.class public core016
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

  invokestatic core016/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; int y = 17 ;
  ldc 17
  istore 0
  ;; while (y > 0)
  L0:
  ldc 1
  iload 0
  ldc 0
  if_icmpgt L2
  pop
  ldc 0
  L2:
  ifeq L1
  ;; y = y - 2 ;
  iload 0
  ldc 2
  isub
  dup
  istore 0
  pop
  goto L0
  L1:
  ;; if (y < 0)
  ldc 1
  iload 0
  ldc 0
  if_icmplt L5
  pop
  ldc 0
  L5:
  ifeq L3
  ;; printInt (0);
  ldc 0
  invokestatic Runtime/printInt(I)V
  ;; return 0 ;
  ldc 0
  ireturn
  goto L4
  L3:
  ;; printInt (1);
  ldc 1
  invokestatic Runtime/printInt(I)V
  ;; return 0 ;
  ldc 0
  ireturn
  L4:
return
.end method
