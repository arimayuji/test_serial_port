double calculateAverage(List<double> values) {
  if (values.isEmpty) return 0;
  
  double sum = values.fold(0, (total, value) => total + value);
  
  return sum / values.length;
}