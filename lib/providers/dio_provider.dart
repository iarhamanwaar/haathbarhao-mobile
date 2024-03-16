import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/dio_interceptor.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(responseType: ResponseType.plain),
  );

  dio.interceptors.add(DioInterceptor(ref));

  return dio;
});
