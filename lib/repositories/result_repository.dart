import '../data/local_data_source.dart';

class ResultRepository {
  final LocalDataSource _localDataSource;

  Future<List<String>> getResultTitle() {
    return _localDataSource.getResultTitle();
  }
}
