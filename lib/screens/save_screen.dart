import 'package:black_ants_app/services/airtime_service.dart'; // Import Airtime service
import 'package:flutter/material.dart';
import 'package:black_ants_app/config/app_constants.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({super.key});

   @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  final _airtimeService = AirtimeService(); // Instance of the service
  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();
   bool _isLoading = false;
   String _statusMessage = '';

  // Example: Add a simple Airtime Loading UI here
  Future<void> _handleLoadAirtime() async {
     if (_phoneController.text.isEmpty || _amountController.text.isEmpty) {
       setState(() {
         _statusMessage = 'Please enter phone number and amount.';
       });
       return;
     }

      final amount = double.tryParse(_amountController.text);
     if (amount == null || amount <= 0) {
       setState(() {
         _statusMessage = 'Please enter a valid amount.';
       });
       return;
     }


      setState(() {
        _isLoading = true;
        _statusMessage = 'Processing...';
      });

     try {
        // TODO: Determine currency based on context or user selection
        // For now, assume a default or handle it properly
        bool success = await _airtimeService.loadAirtime(
           _phoneController.text,
           amount,
           'NGN', // Example: Hardcoded Nigerian Naira - NEEDS PROPER HANDLING
        );
        setState(() {
          _statusMessage = success ? 'Airtime loaded successfully!' : 'Airtime loading failed.';
           if(success) {
             _phoneController.clear();
             _amountController.clear();
           }
        });
      } catch (e) {
        setState(() {
           _statusMessage = 'An error occurred: $e';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
   }

 @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView( // Allows scrolling if content overflows
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Utilities & Savings',
              style: textTheme.headlineSmall?.copyWith(color: theme.colorScheme.primary),
            ),
            const SizedBox(height: 20),

            // --- Airtime Loading Section ---
            Card(
               // Using CardTheme from AppTheme
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                   children: [
                     Text('Load Airtime', style: textTheme.titleLarge),
                     const SizedBox(height: 15),
                     TextField(
                       controller: _phoneController,
                       decoration: const InputDecoration(labelText: 'Phone Number (e.g., +234...)'),
                       keyboardType: TextInputType.phone,
                       style: textTheme.bodyMedium,
                     ),
                      const SizedBox(height: 15),
                      TextField(
                         controller: _amountController,
                        decoration: const InputDecoration(labelText: 'Amount (e.g., 500)'),
                         keyboardType: TextInputType.number,
                          style: textTheme.bodyMedium,
                     ),
                       const SizedBox(height: 20),
                       if (_isLoading)
                         const Center(child: CircularProgressIndicator())
                       else
                          ElevatedButton(
                            // Style from AppTheme
                            onPressed: _handleLoadAirtime,
                            child: const Text('Load Now'),
                           ),
                       if (_statusMessage.isNotEmpty) ...[
                         const SizedBox(height: 15),
                          Text(
                             _statusMessage,
                              style: textTheme.bodyMedium?.copyWith(
                                 color: _statusMessage.contains('failed') || _statusMessage.contains('error')
                                    ? theme.colorScheme.error
                                     : (_statusMessage.contains('successfully') ? Colors.greenAccent : theme.colorScheme.onSurface),
                              ),
                            textAlign: TextAlign.center,
                          ),
                       ],
                    ],
                ),
              ),
            ),

             const SizedBox(height: 30),
             // --- Other Saving Features Placeholder ---
              Text(
               'Savings Goals',
               style: textTheme.titleLarge?.copyWith(color: theme.colorScheme.secondary),
              ),
              const SizedBox(height: 10),
             const ListTile(
               leading: Icon(Icons.account_balance_wallet_outlined, color: AppConstants.primaryGold),
               title: Text('Setup a Savings Goal'),
               subtitle: Text('Automate savings towards your targets.'),
               trailing: Icon(Icons.chevron_right, color: AppConstants.greyText),
               // onTap: () {}, // Navigate to goal setup screen
             ),
               const ListTile(
               leading: Icon(Icons.lock_clock_outlined, color: AppConstants.primaryGold),
               title: Text('Fixed Savings (Locks)'),
                subtitle: Text('Earn higher interest for locking funds.'),
                 trailing: Icon(Icons.chevron_right, color: AppConstants.greyText),
                // onTap: () {}, // Navigate to fixed savings screen
             ),

              const SizedBox(height: 20),
             Center(
              child: Text(
                '(More Savings Features Coming Soon)',
                style: textTheme.labelSmall,
              ),
            )

            // TODO: Add more features like Savings Goals, Budgeting Tools placeholders etc.
          ],
        ),
      ),
    );
  }
}
