import 'package:dio/dio.dart';
import '../utils/app_exceptions.dart';
import '../utils/constants.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  late Dio _dio;

  factory ApiService() {
    return _instance;
  }

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.apiBaseUrl,
        connectTimeout: AppConstants.apiTimeout,
        receiveTimeout: AppConstants.apiTimeout,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('Request: ${options.method} ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('Response: ${response.statusCode}');
          return handler.next(response);
        },
        onError: (error, handler) {
          print('Error: ${error.message}');
          return handler.next(error);
        },
      ),
    );
  }

  Future<T> get<T>({\n    required String endpoint,\n    Map<String, dynamic>? queryParameters,\n    required T Function(dynamic) converter,\n  }) async {\n    try {\n      final response = await _dio.get(\n        endpoint,\n        queryParameters: queryParameters,\n      );\n      return converter(response.data);\n    } on DioException catch (e) {\n      _handleError(e);\n      rethrow;\n    }\n  }

  Future<T> post<T>({\n    required String endpoint,\n    dynamic data,\n    required T Function(dynamic) converter,\n  }) async {\n    try {\n      final response = await _dio.post(\n        endpoint,\n        data: data,\n      );\n      return converter(response.data);\n    } on DioException catch (e) {\n      _handleError(e);\n      rethrow;\n    }\n  }

  void _handleError(DioException error) {\n    if (error.type == DioExceptionType.connectionTimeout) {\n      throw NetworkException(message: 'Connection timeout');\n    } else if (error.type == DioExceptionType.receiveTimeout) {\n      throw NetworkException(message: 'Receive timeout');\n    } else if (error.response != null) {\n      final statusCode = error.response!.statusCode;\n      if (statusCode == 401) {\n        throw UnauthorizedException(message: 'Unauthorized');\n      } else if (statusCode == 404) {\n        throw NotFoundException(message: 'Resource not found');\n      } else {\n        throw ServerException(\n          message: error.response?.data['message'] ?? 'Server error',\n          statusCode: statusCode,\n        );\n      }\n    } else {\n      throw NetworkException(message: error.message ?? 'Unknown error');\n    }\n  }
}
