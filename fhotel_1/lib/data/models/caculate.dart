class PricingResult {
  double? totalAmount;
  String? priceBreakdown;

  PricingResult({this.totalAmount, this.priceBreakdown});

  PricingResult.fromJson(Map<String, dynamic> json) {
    totalAmount = json['totalAmount'] != null
        ? json['totalAmount'].toDouble() // Ensure it's parsed as double
        : 0.0;

    priceBreakdown = json['priceBreakdown'] ?? ""; // Keep as String
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['totalAmount'] = totalAmount;
    data['priceBreakdown'] = priceBreakdown;
    return data;
  }

  // Helper method to split priceBreakdown into lines for easier display
  List<String> getFormattedPriceBreakdown() {
    if (priceBreakdown != null && priceBreakdown!.isNotEmpty) {
      return priceBreakdown!.split('\n'); // Split by line breaks
    }
    return [];
  }
}
