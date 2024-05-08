import 'package:flutter/widgets.dart';

class PaginationScrollController {
  late ScrollController scrollController;
  bool isLoading = false;
  bool stopLoading = false;
  int currentPage = 1;
  double boundaryOffset = 200;
  late Future<bool> Function() loadAction;

  bool reachedOffset() {
    if (!scrollController.hasClients) return true;
    return scrollController.position.maxScrollExtent - scrollController.offset <
        boundaryOffset;
  }

  void init(Future<bool> Function() loadAction, {Function()? initAction}) {
    if (initAction != null) {
      initAction();
    }
    this.loadAction = loadAction;
    scrollController = ScrollController()..addListener(scrollListener);
  }

  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
  }

  void scrollListener() {
    if (!stopLoading) {
      if (reachedOffset() && !isLoading) {
        isLoading = true;
        loadAction().then((shouldStop) {
          isLoading = false;
          if (shouldStop == true) {
            stopLoading = true;
          }
        });
      }
    }
  }
}
