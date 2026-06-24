import 'package:mala3bna/core/network/dio_client.dart';
import 'package:mala3bna/core/network/api_endpoints.dart';
import 'package:mala3bna/features/owner/ownerDashboard/data/models/dashboard_model.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardModel> fetchDashboard();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final DioClient dioClient;

  DashboardRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<DashboardModel> fetchDashboard() async {
    // DioClient.get() already returns response.data (not a Response object)
    final data = await dioClient.get(ApiEndpoints.ownerDashboard);
    print('Dashboard raw response: $data');
    return DashboardModel.fromJson(data as Map<String, dynamic>);
  }
}
