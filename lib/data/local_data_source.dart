class LocalDataSource {
  Future<List<String>> getResultTitle() async {
    // Pseudo Data
    return [
      "Total Mensetsu Time",
      "Average Response Time",
      "Longest Response Time",
      "Shortest Response Time"
    ];
  }
}
