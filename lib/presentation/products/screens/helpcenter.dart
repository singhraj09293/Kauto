import 'package:flutter/material.dart';
import 'package:kauto/core/theme/apptheme.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

  final List<Map<String, String>> faqs = const [
    {
      'question': 'How to place an order?',
      'answer':
          'Browse products, tap "Add to Cart", go to Cart and tap "Proceed to Checkout". Select your address and confirm your order.',
    },
    {
      'question': 'How to track my order?',
      'answer':
          'Go to Profile → My Orders. You will see the status of all your orders there.',
    },
    {
      'question': 'How to cancel an order?',
      'answer':
          'Go to My Orders, select the order you want to cancel and tap "Cancel Order". Cancellation is only available before the order is shipped.',
    },
    {
      'question': 'How to return a product?',
      'answer':
          'Go to My Orders, select the delivered order and tap "Return". Our team will pick up the product within 3-5 business days.',
    },
    {
      'question': 'How to contact support?',
      'answer':
          'You can reach us at support@kauto.com or call us at +91 9876543210 between 9 AM to 6 PM Monday to Saturday.',
    },
    {
      'question': 'How to change my delivery address?',
      'answer':
          'Go to Profile → Shipping Address to add or update your delivery address before placing an order.',
    },
    {
      'question': 'What payment methods are accepted?',
      'answer':
          'We accept UPI, Credit/Debit Cards, Net Banking and Cash on Delivery.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help Center',
          style: TextStyle(
            color: AppTheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Frequently Asked Questions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 5),
            Text(
              'Find answers to common questions below',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: faqs.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: Theme.of(context).brightness == Brightness.dark
                          ? [] // 👈 no shadow in dark mode
                          : [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: Offset(0, 4),
                              ),
                            ],
                    ),
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      leading: Icon(
                        Icons.help_outline,
                        color: AppTheme.primary,
                      ),
                      title: Text(
                        faqs[index]['question']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Text(
                            faqs[index]['answer']!,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
