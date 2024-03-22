class ApiModel<TResponse> {
  final int code;
  final TResponse? response;
  final String? errorMessage;

  bool get succeed => code == 200;

  ApiModel({required this.code, this.response, this.errorMessage});
}
