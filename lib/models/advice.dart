// Placeholder model for financial advice
class FinancialAdvice {
  final String id;
  final String title;
  final String content;
  final DateTime timestamp;
  final AdviceCategory category; // e.g., Savings, Investing, Budgeting

  FinancialAdvice({
    required this.id,
    required this.title,
    required this.content,
    required this.timestamp,
    required this.category,
  });

  // Factory constructor for mock data or from JSON
  factory FinancialAdvice.fromJson(Map<String, dynamic> json) {
    return FinancialAdvice(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: json['title'] ?? 'General Advice',
      content: json['content'] ?? 'No specific advice content available.',
      timestamp: json['timestamp'] != null ? DateTime.parse(json['timestamp']) : DateTime.now(),
      category: _parseCategory(json['category']),
    );
  }

   static AdviceCategory _parseCategory(String? categoryString) {
     switch (categoryString?.toLowerCase()) {
       case 'saving':
       case 'savings':
         return AdviceCategory.savings;
       case 'investing':
         return AdviceCategory.investing;
       case 'trading':
         return AdviceCategory.trading;
       case 'budgeting':
         return AdviceCategory.budgeting;
       default:
         return AdviceCategory.general;
     }
   }
}

enum AdviceCategory {
  general,
  savings,
  investing,
  trading,
  budgeting,
}
