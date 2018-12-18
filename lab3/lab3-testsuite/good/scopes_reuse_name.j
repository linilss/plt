;; BEGIN HEADER

.class public scopes_reuse_name
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

  invokestatic scopes_reuse_name/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; int x = 0 ;
  ldc 0
  istore 0
  ;; if (true)
  ldc 1
  ifeq L0
  ;; int x = 1 ;
  ldc 1
  istore 1
  goto L1
  L0:
  L1:
  ;; printInt (x);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; if (true)
  ldc 1
  ifeq L2
  ;; int x ;
  ;; x = 2 ;
  ldc 2
  dup
  istore 2
  pop
  goto L3
  L2:
  L3:
  ;; printInt (x);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; if (false)
  ldc 0
  ifeq L4
  goto L5
  L4:
  ;; int x = 3 ;
  ldc 3
  istore 3
  L5:
  ;; printInt (x);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; if (false)
  ldc 0
  ifeq L6
  goto L7
  L6:
  ;; int x ;
  ;; x = 4 ;
  ldc 4
  dup
  istore 4
  pop
  L7:
  ;; printInt (x);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; int i = 0 ;
  ldc 0
  istore 5
  ;; while (i ++ < 1)
  L8:
  ldc 1
  iload 5
  iload 5
  ldc 1
  iadd
  istore 5
  ldc 1
  if_icmplt L10
  pop
  ldc 0
  L10:
  ifeq L9
  ;; int x = 5 ;
  ldc 5
  istore 6
  goto L8
  L9:
  ;; printInt (x);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; int i = 0 ;
  ldc 0
  istore 7
  ;; while (i ++ < 1)
  L11:
  ldc 1
  iload 7
  iload 7
  ldc 1
  iadd
  istore 7
  ldc 1
  if_icmplt L13
  pop
  ldc 0
  L13:
  ifeq L12
  ;; int x ;
  ;; x = 6 ;
  ldc 6
  dup
  istore 8
  pop
  goto L11
  L12:
  ;; printInt (x);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; int x = 7 ;
  ldc 7
  istore 9
  ;; printInt (x);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; int x ;
  ;; x = 8 ;
  ldc 8
  dup
  istore 10
  pop
  ;; printInt (x);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; return 0 ;
  ldc 0
  ireturn
return
.end method
