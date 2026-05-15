import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../models/parcel.dart';

class InstallationService {
  final Dio _dio = ApiClient().dio;

  Future<List<Parcel>> getAll() async {
    final response = await _dio.get('/installations');
    final list = response.data['installations'] as List;
    return list
        .map((e) => Parcel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _dio.post('/installations', data: data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _dio.patch('/installations/$id', data: data);
  }

  Future<void> delete(String id) async {
    await _dio.delete('/installations/$id');
  }
}
