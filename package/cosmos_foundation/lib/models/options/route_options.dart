/// Route options to handle a Route node inside the Routing tree manager.
class RouteOptions {
  /// Simplified identifier.
  final String? _name;

  /// Raw path.
  final String _path;

  /// Current Route node path.
  String get path {
    /// --> The raw path should start with '/' if not, then it should be pa
    if (_path.startsWith('/')) return _path;
    return '/$_path';
  }

  String get name {
    final String parsedPath = path.substring(1);
    if ((_name != null && _name!.isEmpty) || parsedPath.isEmpty) return 'init-path-parsed';
    if (_name != null && _name!.startsWith('/')) return _name!.substring(1);
    if (_name != null) return _name as String;
    return hashCode.toString();
  }

  const RouteOptions(String path, {String? name})
      : _path = path,
        _name = name;
  
  @override
  String toString() {
    return '$_path | $hashCode';
  }
}
