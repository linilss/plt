int main () {
  int i = 1;
  int j = 0;
      // Lab 3 only comment:
      // Initialization of j would not be needed as the access of j
      // is in dead code, if compiled correctly.
      // However, the JVM bytecode verifier is picky and will complain.
  if (true && true) {
    printInt(i);
  } else {
    printInt (42);
  }

  return 0;
}
