import 'package:dio/dio.dart';
import 'package:time_tracking_app/shared/network/configs/service_config.dart';

abstract class HttpClient {
  late final Dio client;
  late final ServiceConfig serviceConfig;
}

class DioHttpClient implements HttpClient {
  ///Creates factory methods that takes in a Service config & Dio object
  factory DioHttpClient(ServiceConfig serviceConfig) {
    final httpClient =
        DioHttpClient._internal(serviceConfig, Dio(serviceConfig.baseOptions));
    httpClient.client.interceptors.addAll(serviceConfig.getInterceptors());
    return httpClient;
  }

  DioHttpClient._internal(this.serviceConfig, this.client);

  @override
  Dio client;

  @override
  ServiceConfig serviceConfig;
}
