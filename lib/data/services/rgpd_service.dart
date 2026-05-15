import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';

class RgpdService {
  final Dio _dio = ApiClient().dio;

  Future<Map<String, dynamic>> exportData() async {
    final response = await _dio.get('/rgpd/export');
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<void> downloadData({String format = 'json'}) async {
    await _dio.get('/rgpd/download', queryParameters: {'format': format});
  }

  Future<void> rectifyData(Map<String, dynamic> data) async {
    await _dio.patch('/rgpd/rectify', data: data);
  }

  Future<void> deleteAccount() async {
    await _dio.delete('/rgpd/delete');
  }
}
