;; BEGIN HEADER

.class public core103
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

  invokestatic core103/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; int j = 4 ;
  ldc 4
  istore 0
  ;; while (j < 6)
  L0:
  ldc 1
  iload 0
  ldc 6
  if_icmplt L2
  pop
  ldc 0
  L2:
  ifeq L1
  ;; int i = 0 ;
  ldc 0
  istore 1
  ;; i ++ ;
  iload 1
  iload 1
  ldc 1
  iadd
  istore 1
  pop
  ;; printInt (i);
  iload 1
  invokestatic Runtime/printInt(I)V
  ;; j ++ ;
  iload 0
  iload 0
  ldc 1
  iadd
  istore 0
  pop
  goto L0
  L1:
  ;; if (j < 7)
  ldc 1
  iload 0
  ldc 7
  if_icmplt L5
  pop
  ldc 0
  L5:
  ifeq L3
  ;; j ++ ;
  iload 0
  iload 0
  ldc 1
  iadd
  istore 0
  pop
  goto L4
  L3:
  ;; j -- ;
  iload 0
  iload 0
  ldc 1
  isub
  istore 0
  pop
  L4:
  ;; printInt (j);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; return j ;
  iload 0
  ireturn
return
.end method
