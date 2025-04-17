import 'package:black_ants_app/services/stock_market_service.dart'; // Import Stock service
import 'package:flutter/material.dart';
import 'package:black_ants_app/config/app_constants.dart';

class TradeScreen extends StatefulWidget {
  const TradeScreen({super.key});

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  final _stockService = StockMarketService();
  List<dynamic> _marketData = []; // Holds fetched market data
  bool _isLoading = true;
  String? _selectedExchange = 'JSE'; // Default or from user pref
  final List<String> _exchanges = ['JSE', 'NSE', 'BRVM', 'GSE']; // Example exchanges

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => _isLoading = true);
    try {
      // In real app, pass the currently selected exchange
      final data = await _stockService.fetchMarketData(_selectedExchange ?? _exchanges[0]);
      setState(() {
        _marketData = data;
        _isLoading = false;
      });
    } catch (e) {
      // Log the error (replace print with a logger in production)
      debugPrint("Error fetching market data: $e");
      setState(() => _isLoading = false);
      if (mounted) {
        // Show error message to user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load market data for $_selectedExchange.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.all(8.0), // Less padding for list view
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'African Markets',
                  style: textTheme.headlineSmall?.copyWith(color: theme.colorScheme.primary),
                ),
                // Simple Exchange Selector Dropdown
                DropdownButton<String>(
                  value: _selectedExchange,
                  icon: Icon(Icons.arrow_drop_down, color: theme.colorScheme.primary),
                  dropdownColor: AppConstants.offBlack,
                  underline: Container(
                    height: 1,
                    color: theme.colorScheme.primary.withOpacity(0.5),
                  ),
                  style: textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface),
                  onChanged: (String? newValue) {
                    if (newValue != null && newValue != _selectedExchange) {
                      setState(() {
                        _selectedExchange = newValue;
                        _marketData = []; // Clear old data
                      });
                      _fetchData(); // Fetch data for new exchange
                    }
                  },
                  items: _exchanges.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Loading or List View
          Expanded(
            // Takes remaining space
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _marketData.isEmpty
                    ? Center(child: Text('No data available for $_selectedExchange.', style: textTheme.bodyMedium))
                    : ListView.builder(
                        itemCount: _marketData.length,
                        itemBuilder: (context, index) {
                          final stock = _marketData[index];
                          final priceChange = stock['change'] as String? ?? '0%';
                          final isPositive = priceChange.startsWith('+');
                          final color = isPositive ? Colors.greenAccent : Colors.redAccent;

                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              title: Text(stock['name'] ?? 'Unknown Stock', style: textTheme.titleMedium),
                              subtitle: Text(stock['symbol'] ?? '---',
                                  style: textTheme.labelSmall?.copyWith(color: AppConstants.greyText)),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${stock['price']?.toStringAsFixed(2) ?? 'N/A'}', // Format price
                                    style: textTheme.titleMedium,
                                  ),
                                  Text(
                                    priceChange,
                                    style: textTheme.bodyMedium?.copyWith(color: color),
                                  ),
                                ],
                              ),
                              onTap: () {
                                // TODO: Navigate to stock detail screen / Show buy/sell options
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Tapped on ${stock['symbol']}. Detail view coming soon.')),
                                );
                                // Example of calling a mock buy function:
                                // _stockService.executeBuyOrder(stock['symbol'], 10, stock['price']);
                              },
                            ),
                          );
                        },
                      ),
          ),
          const SizedBox(height: 10),
          // Placeholder for actual trading actions
          Center(
            child: Text(
              '(Real-time data & trading integration pending)',
              style: textTheme.labelSmall,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
