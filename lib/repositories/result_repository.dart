import '../data/local_data_source.dart';

class ResultRepository {
  late final LocalDataSource _localDataSource;

  ResultRepository() {
    _localDataSource = LocalDataSource();
  }

  Future<List<String>> getResultTitle() {
    return _localDataSource.getResultTitle();
  }
}
