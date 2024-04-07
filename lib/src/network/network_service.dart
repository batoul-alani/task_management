import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:maids_tasks_manager/src/constants/services_urls.dart';
import 'package:maids_tasks_manager/src/utils/app_constants.dart';

abstract class NetworkService<T> {
  Future<T> get(
      {required String endpoint, Map<String, dynamic>? queryParameters});
  Future<T> post(
      {required String endpoint, dynamic data, Map<String, dynamic>? headers});
  Future<T> put(
      {required String endpoint, dynamic data, Map<String, dynamic>? queryParameters});
  Future<T> delete(
      {required String endpoint, Map<String, dynamic>? queryParameters});
}

class DioNetworkService extends NetworkService<Response> {
  final Dio _dio;

  DioNetworkService()
      : _dio = Dio(BaseOptions(
          baseUrl: ServicesUrls.baseUrl,
          receiveTimeout: AppConstants.dioTimeout,
          connectTimeout: AppConstants.dioTimeout,
          sendTimeout: AppConstants.dioTimeout,
        )) {
    _dio.interceptors.add(DioAppInterceptors());
    if (kDebugMode) {
      _dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }
  }

  @override
  Future<Response> get(
          {required String endpoint, Map<String, dynamic>? queryParameters}) =>
      _dio.get(endpoint, queryParameters: queryParameters);

  @override
  Future<Response> post(
          {required String endpoint,
          dynamic data,
          Map<String, dynamic>? headers}) =>
      _dio.post(endpoint, data: data, options: Options(headers: headers));

  @override
  Future<Response> delete(
          {required String endpoint, Map<String, dynamic>? queryParameters}) =>
      _dio.delete(endpoint, queryParameters: queryParameters);

  @override
  Future<Response> put(
          {required String endpoint, data, Map<String, dynamic>? queryParameters}) =>
      _dio.put(endpoint, data: data, queryParameters: queryParameters);
}

class DioAppInterceptors extends Interceptor {
  DioAppInterceptors();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      debugPrint(err.response!.data.toString());
    }
    final String? message = err.response?.data['message'];
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions, message);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions, message);
          case 401:
            throw UnauthorizedException(err.requestOptions, message);
          case 403:
            throw AccessForbiddenException(err.requestOptions, message);
          case 404:
            throw NotFoundException(err.requestOptions, message);
          case 409:
            throw ConflictException(err.requestOptions, message);
          case 422:
            throw UnprocessableEntityException(err.requestOptions, message);
          case 500:
            throw InternalServerErrorException(err.requestOptions, message);
          default:
            throw BadResponseException(err.requestOptions, message);
        }
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        throw NoInternetConnectionException(err.requestOptions, message);
      case DioExceptionType.badCertificate:
        throw BadCertificateException(err.requestOptions, message);
      case DioExceptionType.connectionError:
        throw ConnectionErrorException(err.requestOptions, message);
    }
    return handler.next(err);
  }
}

class ApiException extends DioException {
  ApiException(RequestOptions requestOptions, [this.customMessage])
      : super(requestOptions: requestOptions, error: customMessage);

  final String? customMessage;

  String get defaultErrorString => "Request Error";

  @override
  String toString() {
    return customMessage ?? defaultErrorString;
  }
}

class BadRequestException extends ApiException {
  BadRequestException(super.requestOptions, [super.message]);

  @override
  String get defaultErrorString => "Bad Request";
}

class UnprocessableEntityException extends ApiException {
  UnprocessableEntityException(super.requestOptions, [super.message]);

  @override
  String get defaultErrorString => "Unprocessable Entity";
}

class InternalServerErrorException extends ApiException {
  InternalServerErrorException(super.requestOptions, [super.message]);

  @override
  String get defaultErrorString => "Internal Server Error";
}

class ConflictException extends ApiException {
  ConflictException(super.requestOptions, [super.message]);

  @override
  String get defaultErrorString => "Conflict Connection";
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(super.requestOptions, [super.message]);

  @override
  String get defaultErrorString => "Unauthorized";
}

class NotFoundException extends ApiException {
  NotFoundException(super.requestOptions, [super.message]);

  @override
  String get defaultErrorString => "Not Found";
}

class NoInternetConnectionException extends ApiException {
  NoInternetConnectionException(super.requestOptions, [super.message]);

  @override
  String get defaultErrorString => "No Internet Connection";
}

class DeadlineExceededException extends ApiException {
  DeadlineExceededException(super.requestOptions, [super.message]);

  @override
  String get defaultErrorString => "Deadline Exceeded";
}

class AccessForbiddenException extends ApiException {
  AccessForbiddenException(super.requestOptions, [super.message]);

  @override
  String get defaultErrorString => "Access Forbidden";
}

class BadCertificateException extends ApiException {
  BadCertificateException(super.requestOptions, [super.message]);
  @override
  String get defaultErrorString => "Bad Certificate";
}

class ConnectionErrorException extends ApiException {
  ConnectionErrorException(super.requestOptions, [super.message]);
  @override
  String get defaultErrorString => "Connection Error";
}

class BadResponseException extends ApiException {
  BadResponseException(super.requestOptions, [super.message]);
  @override
  String get defaultErrorString =>
      'Something went wrong! Please contact our customer support.';
}

class AppException implements Exception {
  final dynamic message;

  AppException([this.message]);

  @override
  String toString() {
    return message == null ? '' : message.toString();
  }
}
