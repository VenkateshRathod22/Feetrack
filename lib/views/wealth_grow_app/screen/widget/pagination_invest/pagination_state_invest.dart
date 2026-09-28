class PaginationStateInvest<T> {
  int page;
  int lastPage;

  final int pageSize;

  bool isInitialLoading;
  bool isMoreLoading;

  final List<T> items;

  final Set<dynamic> dedupeIds;

  PaginationStateInvest({
    this.page = 1,
    this.lastPage = 1,
    this.pageSize = 10,
    this.isInitialLoading = false,
    this.isMoreLoading = false,
    List<T>? initialItems,
  })  : items = initialItems ?? <T>[],
        dedupeIds = <dynamic>{};

  bool get canLoadMore => page < lastPage;

  void reset() {
    page = 1;
    lastPage = 1;
    isInitialLoading = false;
    isMoreLoading = false;
    items.clear();
    dedupeIds.clear();
  }

  void setItems(
    List<T> newItems, {
    dynamic Function(T item)? getId,
  }) {
    items.clear();
    dedupeIds.clear();

    for (final item in newItems) {
      if (getId != null) {
        final id = getId(item);

        if (id != null && dedupeIds.contains(id)) {
          continue;
        }

        if (id != null) {
          dedupeIds.add(id);
        }
      }

      items.add(item);
    }
  }

  void appendItems(
    List<T> newItems, {
    dynamic Function(T item)? getId,
  }) {
    for (final item in newItems) {
      if (getId != null) {
        final id = getId(item);

        if (id != null) {
          if (dedupeIds.contains(id)) {
            continue;
          }

          dedupeIds.add(id);
        }
      }

      items.add(item);
    }
  }
}