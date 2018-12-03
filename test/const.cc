  int main ()
  {
    int i = 1;
    printInt(i);
    bool t = true; 
    bool f = false; 

    while(t || f) {
      i++;
      printInt(i);
    }
    printInt(i);
  }
