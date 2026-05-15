import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../models/stock.dart';

class InventoryService {
  final Dio _dio = ApiClient().dio;

  Future<List<Stock>> getAll() async {
    final response = await _dio.get('/inventory');
    final list = response.data['inventory'] as List;
    return list
        .map((e) => Stock.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _dio.post('/inventory', data: data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _dio.patch('/inventory/$id', data: data);
  }

  Future<void> delete(String id) async {
    await _dio.delete('/inventory/$id');
  }
}
