import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_tracking_app/core/services/local_storage_service.dart';
import 'package:time_tracking_app/data/data_source/task_datasource.dart';
import 'package:time_tracking_app/domain/repository/task_repository.dart';
import 'package:time_tracking_app/shared/network/client/http_client.dart';
import 'package:time_tracking_app/shared/network/client/rest_api_client.dart';
import 'package:time_tracking_app/shared/network/configs/service_config.dart';

final dependency = GetIt.instance;

class Injector {
  Injector._();

  /// This function is responsible for setting up the dependencies
  /// and registering them with the dependency injection container.
  /// It should be called only once in the application.
  static Future<void> setup() async {
    // Set up the shared preferences dependency
    _setupSharedPreferences();

    // Set up the HTTP client dependency
    _setupHttpClient();

    // Set up the base options dependency
    _setupBaseOptions();

    // Set up the service configuration dependency
    _setupServiceConfig();

    // Set up the REST API client dependency
    _setupRestApiClient();

    // Set up the task data source dependency
    _setupTaskDataSource();

    // Set up the task repository dependency
    _setupTaskRepository();
  }

  static Future<void> _setupSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    dependency.registerSingleton<SharedPreferencesManager>(
      SharedPreferencesManager(prefs),
    );
  }

  static void _setupServiceConfig() {
    dependency.registerFactory(
      () => ServiceConfig(dependency<BaseOptions>()),
    );
  }

  static void _setupBaseOptions() {
    /// adding token here as it is static across app otherwise it will be handled in interceptor
    dependency.registerFactory(
      () => BaseOptions(baseUrl: 'https://api.todoist.com/rest/v2/', headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer 77ba91243e5e5c7372ced70003b0f75ecf355252',
      }),
    );
  }

  static Future<void> _setupTaskRepository() async {
    dependency.registerSingleton<TaskRepository>(
      TaskRepositoryImp(dependency()),
    );
  }

  static Future<void> _setupTaskDataSource() async {
    dependency.registerSingleton<TaskDatasource>(
      TaskDatasourceImpl(dependency()),
    );
  }

  static void _setupHttpClient() {
    dependency.registerFactory<HttpClient>(
      () => DioHttpClient(dependency()),
    );
  }

  static Future<void> _setupRestApiClient() async {
    dependency.registerSingleton<RestAPIClient>(
      RestAPIClient(
        dependency<HttpClient>().client,
      ),
    );
  }
}
