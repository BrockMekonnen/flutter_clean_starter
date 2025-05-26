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

  ResultPage(
    this.current,
    this.pageSize,
    this.totalPages,
    this.totalElements,
    this.first,
    this.last,
  );

  ResultPage.empty()
      : current = 0,
        pageSize = 0,
        totalPages = 0,
        totalElements = 0,
        first = true,
        last = true;
}

typedef Filter = Map<String, dynamic>;

abstract class Query {
  const Query();
}

class FilteredQuery<F extends Filter> extends Query {
  final F filter;

  const FilteredQuery({required this.filter});
}

class PaginatedQuery<F extends Filter> extends FilteredQuery<F> {
  final Pagination pagination;

  const PaginatedQuery({required super.filter, required this.pagination});
}

class SortedQuery<F extends Filter> extends FilteredQuery<F> {
  final List<Sort> sort;

  const SortedQuery({required super.filter, required this.sort});
}

class SortedPaginatedQuery<F extends Filter> extends FilteredQuery<F> {
  final List<Sort> sort;
  final Pagination pagination;

  const SortedPaginatedQuery({
    required super.filter,
    required this.sort,
    required this.pagination,
  });
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
