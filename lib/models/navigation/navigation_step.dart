abstract class NavigationStep {
  final String navigationPath;

  const NavigationStep({required this.navigationPath});

  String navigationFromBasePath(String basePath) => '$basePath/$navigationPath';
}
