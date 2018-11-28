    int scope_violation (int x) {
      int x = 1;
      {
        int y = 2;
        int y;
      }
      return x;
    }