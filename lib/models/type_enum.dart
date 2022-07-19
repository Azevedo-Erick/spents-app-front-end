enum Type {
  SPENT(1, 'Gasto'),
  INCOME(2, 'Receita');

  final String _name;
  final int _id;

  const Type(this._id, this._name);

  String get name {
    return _name;
  }

  int get id {
    return _id;
  }

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
