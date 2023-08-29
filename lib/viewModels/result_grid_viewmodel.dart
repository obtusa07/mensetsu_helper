import 'package:flutter/material.dart';
import '../repositories/result_repository.dart';

class ResultGridViewModel with ChangeNotifier {
  late final ResultRepository _resultRepository;

  List<String> get titles => _titles;
  List<String> _titles = [];

  ResultGridViewModel() {
    _resultRepository = ResultRepository();
    _loadTitles();
  }

  Future<void> _loadTitles() async {
    _titles = await _resultRepository.getResultTitle();
    notifyListeners();
  }
}
