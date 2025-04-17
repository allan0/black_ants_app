import 'dart:math';
import 'package:black_ants_app/models/advice.dart';
import 'package:flutter/foundation.dart'; // For kDebugMode

// --- Conceptual AI Multi-Agent System Notes ---
// This is a MOCK service. In a real application:
// 1. This service would interact with a backend API.
// 2. The backend would host and manage multiple specialized AI agents:
//    - Market Analysis Agent: Tracks African stock markets (JSE, NSE, etc.).
//    - Risk Assessment Agent: Analyzes user profile and suggests suitable risk levels.
//    - Portfolio Optimization Agent: Suggests investment allocations.
//    - News/Sentiment Analysis Agent: Processes financial news relevant to Africa.
//    - User Profile Agent: Understands user's goals, risk tolerance, current holdings.
//    - Orchestrator Agent: Coordinates queries between agents to generate comprehensive advice.
// 3. Input to the system could include user profile, market data, specific user queries.
// 4. Output would be personalized, actionable advice (like the mock data below).
// --- End Conceptual Notes ---


class AiAdviceService {

  // Simulate network delay and AI processing time
  final Duration _processingDelay = Duration(seconds: kDebugMode ? 1 : 3); // Shorter delay for debugging

  // Mock database of advice templates
  final List<Map<String, String>> _mockAdviceTemplates = [
    { "category": "investing", "title": "Diversification is Key", "content": "Consider diversifying your investments across different sectors (e.g., finance, tech, agriculture) and potentially across different African exchanges (like JSE, NSE, BRVM) to mitigate risk." },
    { "category": "savings", "title": "Emergency Fund First", "content": "Before aggressive investing, ensure you have an emergency fund covering 3-6 months of living expenses. Keep this in a safe, easily accessible account." },
    { "category": "trading", "title": "Understand Fees", "content": "Be aware of brokerage fees, transaction costs, and potential currency conversion fees when trading cross-border stocks. These can impact your net returns significantly." },
    { "category": "budgeting", "title": "Track Your Spending", "content": "Use a budgeting app or spreadsheet to track where your money goes. Identifying spending patterns is the first step to saving more effectively." },
    { "category": "investing", "title": "Long-Term Perspective", "content": "Investing in the stock market is generally a long-term game. Avoid making impulsive decisions based on short-term market fluctuations, especially in volatile markets." },
    { "category": "savings", "title": "Automate Your Savings", "content": "Set up automatic transfers from your main account to your savings or investment account right after you get paid. 'Pay yourself first'."},
    { "category": "general", "title": "Stay Informed", "content": "Keep up-to-date with financial news, especially developments within the African economies you're interested in. Knowledge is crucial for making sound financial decisions." },
     { "category": "investing", "title": "Consider ETFs", "content": "Exchange-Traded Funds (ETFs) that track African indices or sectors can be a good way to get broad market exposure with lower individual stock risk." },
  ];

  // Simulates fetching personalized advice from the AI system
  Future<FinancialAdvice> fetchFinancialAdvice({String? userId, List<String>? interests}) async {
    // In a real app, userId and interests would be sent to the backend
    // The backend AI agents would use this info to generate personalized advice

    await Future.delayed(_processingDelay);

    // For this MVP, return a random piece of mock advice
    final random = Random();
    final mockData = _mockAdviceTemplates[random.nextInt(_mockAdviceTemplates.length)];

    return FinancialAdvice.fromJson({
      'id': 'advice-${DateTime.now().millisecondsSinceEpoch}',
      'title': mockData['title'],
      'content': mockData['content'],
      'category': mockData['category'],
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

    // Simulate fetching a list of advice tips
   Future<List<FinancialAdvice>> fetchAdviceList({int count = 5}) async {
      await Future.delayed(_processingDelay); // Simulate network/processing

      final random = Random();
      List<FinancialAdvice> adviceList = [];
      List<Map<String, String>> availableTemplates = List.from(_mockAdviceTemplates); // Copy to avoid modifying original

      for (int i = 0; i < count; i++) {
         if (availableTemplates.isEmpty) break; // Stop if we run out of unique templates
         final index = random.nextInt(availableTemplates.length);
         final mockData = availableTemplates.removeAt(index); // Pick and remove

         adviceList.add(FinancialAdvice.fromJson({
           'id': 'advice-list-${DateTime.now().millisecondsSinceEpoch}-$i',
           'title': mockData['title'],
           'content': mockData['content'],
           'category': mockData['category'],
           'timestamp': DateTime.now().toIso8601String(),
         }));
      }
      return adviceList;
   }
}
