class AppResponse<T> {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final T data;

  AppResponse(
      {required this.page,
      required this.perPage,
      required this.total,
      required this.totalPages,
      required this.data});

  factory AppResponse.fromMap(
          Map<String, dynamic> json, Function(dynamic) create) =>
      AppResponse(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: json['data'] != null ? create(json['data']) : null,
      );
}
