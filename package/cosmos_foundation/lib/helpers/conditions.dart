class Conditions {
  static Conditions? _instance;
  // Avoid self instance
  Conditions._();
  static Conditions get i => _instance ??= Conditions._();

  bool isSomeone<T>(T reference, List<T> cases) {
    for (T vcase in cases) {
      if (vcase == reference) return true;
    }
    return false;
  }
}
