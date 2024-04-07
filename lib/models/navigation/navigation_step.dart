class NavigationStep {
  final String navigationPath;

  NavigationStep({required this.navigationPath});

  String navigationFromBasePath(String basePath) => '$basePath/$navigationPath';
}
