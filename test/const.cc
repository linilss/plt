int main () {
  int x = 0;

  if (true)
    { int x = 1; }
  else
    {}
  printInt(x);

  if (true) {
    int x;
    x = 2;
  }
  else
    {}
  printInt(x);

  return 0;
}
