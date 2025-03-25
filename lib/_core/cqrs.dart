// ignore_for_file: file_names

class Sort {
  final String field;
  final String direction;

  Sort(this.field, this.direction);
}

class Pagination {
  final int page;
  final int pageSize;

  Pagination(this.page, this.pageSize);
}

class ResultPage {
  final int current;
  final int pageSize;
  final int totalPages;
  final int totalElements;
  final bool first;
  final bool last;

  ResultPage({
    required this.current,
    required this.pageSize,
    required this.totalPages,
    required this.totalElements,
    required this.first,
    required this.last,
  });

  ResultPage.empty()
      : current = 0,
        pageSize = 0,
        totalPages = 0,
        totalElements = 0,
        first = true,
        last = true;
}

class FilteredQueryResult<T, F> {
  final F? filter;
  final T? data;
  final ResultPage? page;

  FilteredQueryResult({
    this.data,
    this.page,
    this.filter,
  });

  FilteredQueryResult<T, F> copyWith({
    T? data,
    F? filter,
    ResultPage? page,
  }) =>
      FilteredQueryResult<T, F>(
        data: data ?? this.data,
        filter: filter ?? this.filter,
        page: page ?? ResultPage.empty(),
      );
}

class QueryResult<T> {
  final T? data;
  final ResultPage? page;

  QueryResult<T> copyWith({
    T? data,
    ResultPage? page,
  }) =>
      QueryResult<T>(
        data: data ?? this.data,
        page: page ?? ResultPage.empty(),
      );

  QueryResult({this.data, this.page});
}
