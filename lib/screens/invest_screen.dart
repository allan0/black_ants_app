import 'package:flutter/material.dart';
import 'package:black_ants_app/config/app_constants.dart';
import '../config/app_constants.dart'; // Use AppConstants

class InvestScreen extends StatelessWidget {
  const InvestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView( // Allows scrolling
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Investment Portfolio',
              style: textTheme.headlineSmall?.copyWith(color: theme.colorScheme.primary),
            ),
            const SizedBox(height: 20),

            // --- Portfolio Overview Placeholder ---
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text('Total Value', style: textTheme.titleLarge),
                         Text(
                           'Coming Soon', // Placeholder Value
                           style: textTheme.headlineSmall?.copyWith(color: theme.colorScheme.primary),
                         ),
                      ],
                    ),
                     const SizedBox(height: 10),
                      Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                          Text('Total Gain/Loss', style: textTheme.bodyMedium),
                           Text(
                              '--', // Placeholder Gain/Loss
                               style: textTheme.bodyLarge?.copyWith(color: AppConstants.greyText), // Neutral color for placeholder
                            ),
                        ],
                      ),
                     const Divider(height: 30, thickness: 0.5),
                      Center(
                        child: ElevatedButton(
                         onPressed: () {
                           // TODO: Navigate to Add Funds Screen
                           ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Add Funds functionality pending.'))
                            );
                         },
                          child: const Text('Add Funds'),
                         ),
                      ),
                  ],
                ),
              ),
            ),

             const SizedBox(height: 30),

              // --- Investment Opportunities ---
             Text(
              'Explore Opportunities',
               style: textTheme.titleLarge?.copyWith(color: theme.colorScheme.secondary),
              ),
               const SizedBox(height: 15),

             _buildInvestmentOption(
               context,
               icon: Icons.business_center_outlined,
                title: 'African Stocks',
                description: 'Browse and invest in listed companies across major African exchanges.',
                 onTap: () { /* Maybe navigate to Trade screen */ },
            ),
             _buildInvestmentOption(
                context,
               icon: Icons.donut_large_outlined,
                title: 'ETFs & Thematic Baskets',
                description: 'Invest in diversified baskets focusing on specific sectors or regions.',
                onTap: () { /* Navigate to ETF screen */ },
            ),
            _buildInvestmentOption(
               context,
              icon: Icons.real_estate_agent_outlined,
              title: 'Alternative Investments',
               description: 'Explore opportunities in real estate, agriculture tech, etc. (Future)',
              enabled: false, // Indicate future feature
            ),

              const SizedBox(height: 30),
             Center(
               child: Text(
                 '(Portfolio tracking and more investment options coming soon!)',
                  style: textTheme.labelSmall,
               ),
            )
          ],
        ),
      ),
    );
  }

  // Helper widget for investment options
  Widget _buildInvestmentOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    VoidCallback? onTap,
     bool enabled = true,
   }) {
      final theme = Theme.of(context);
      final textTheme = theme.textTheme;
     final color = enabled ? theme.colorScheme.primary : AppConstants.greyText;
      final textColor = enabled ? theme.colorScheme.onSurface : AppConstants.greyText;

    return Card(
       margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell( // Make tappable
        onTap: enabled ? onTap : null,
         borderRadius: BorderRadius.circular(12), // Match card shape
         child: Padding(
          padding: const EdgeInsets.all(16.0),
           child: Row(
             children: [
                Icon(icon, color: color, size: 30),
               const SizedBox(width: 16),
                Expanded(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         title,
                          style: textTheme.titleMedium?.copyWith(color: textColor),
                        ),
                       const SizedBox(height: 4),
                        Text(
                           description,
                          style: textTheme.bodySmall?.copyWith(color: AppConstants.greyText),
                       ),
                    ],
                   ),
                ),
                if(enabled)
                    Icon(Icons.chevron_right, color: AppConstants.greyText)
                else
                   Text('(Soon)', style: textTheme.labelSmall?.copyWith(color: AppConstants.greyText)),
            ],
           ),
         ),
       ),
     );
   }
}
