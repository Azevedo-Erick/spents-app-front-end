enum Type {
  SPENT,
  INCOME;

  static Type? getType(String type) {
    switch (type) {
      case 'SPENT':
        return SPENT;
      case 'INCOME':
        return INCOME;
      default:
        return null;
    }
  }
}
