;; BEGIN HEADER

.class public state_propagation
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

  invokestatic state_propagation/main()I
  pop
  return

.end method

;; END HEADER

.method public static id(I)I
  .limit locals 100
  .limit stack  100
  ;; return x ;
  iload 0
  ireturn
return
.end method

.method public static main()I
  .limit locals 100
  .limit stack  100
  ;; int z = 0 ;
  ldc 0
  istore 0
  ;; id (++ z);
  iload 0
  ldc 1
  iadd
  istore 0
  iload 0
  invokestatic state_propagation/id(I)I
  pop
  ;; printInt (z);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; id (z = z + 1);
  iload 0
  ldc 1
  iadd
  dup
  istore 0
  invokestatic state_propagation/id(I)I
  pop
  ;; printInt (z);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; z ++ + z ++ ;
  iload 0
  iload 0
  ldc 1
  iadd
  istore 0
  iload 0
  iload 0
  ldc 1
  iadd
  istore 0
  iadd
  pop
  ;; printInt (z);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; z ++ == z ++ ;
  ldc 1
  iload 0
  iload 0
  ldc 1
  iadd
  istore 0
  iload 0
  iload 0
  ldc 1
  iadd
  istore 0
  if_icmpeq L0
  pop
  ldc 0
  L0:
  pop
  ;; printInt (z);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; if (++ z == 7)
  ldc 1
  iload 0
  ldc 1
  iadd
  istore 0
  iload 0
  ldc 7
  if_icmpeq L3
  pop
  ldc 0
  L3:
  ifeq L1
  ;; printInt (z);
  iload 0
  invokestatic Runtime/printInt(I)V
  goto L2
  L1:
  L2:
  ;; printInt (z);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; if (z ++ == 8)
  ldc 1
  iload 0
  iload 0
  ldc 1
  iadd
  istore 0
  ldc 8
  if_icmpeq L6
  pop
  ldc 0
  L6:
  ifeq L4
  goto L5
  L4:
  ;; printInt (z);
  iload 0
  invokestatic Runtime/printInt(I)V
  L5:
  ;; printInt (z);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; while (++ z == 9)
  L7:
  ldc 1
  iload 0
  ldc 1
  iadd
  istore 0
  iload 0
  ldc 9
  if_icmpeq L9
  pop
  ldc 0
  L9:
  ifeq L8
  ;; printInt (z);
  iload 0
  invokestatic Runtime/printInt(I)V
  goto L7
  L8:
  ;; printInt (z);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; while (z ++ == 11)
  L10:
  ldc 1
  iload 0
  iload 0
  ldc 1
  iadd
  istore 0
  ldc 11
  if_icmpeq L12
  pop
  ldc 0
  L12:
  ifeq L11
  goto L10
  L11:
  ;; printInt (z);
  iload 0
  invokestatic Runtime/printInt(I)V
  ;; return 0 ;
  ldc 0
  ireturn
return
.end method
