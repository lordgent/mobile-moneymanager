class CreatePaymentResponse {
  final String token;
  final String url;

  CreatePaymentResponse(
    this.token,
    this.url,
  );

  factory CreatePaymentResponse.fromJson(Map<String, dynamic> json) {
    return CreatePaymentResponse(
      json['data']?['token']?.toString() ?? '-',
      json['data']?['redirect_url']?.toString() ?? '',
    );
  }
}
