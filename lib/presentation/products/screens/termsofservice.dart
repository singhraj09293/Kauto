import 'package:flutter/material.dart';
import 'package:kauto/core/theme/apptheme.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms & Conditions',
          style: TextStyle(
            color: AppTheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last updated: August 1, 2026',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            SizedBox(height: 20),
            _buildSection(
              '1. Acceptance of Terms',
              'By downloading, installing or using the KAUTO app, you agree to be bound by these Terms and Conditions. If you do not agree to these terms, please do not use our app.',
            ),
            _buildSection(
              '2. Use of the App',
              'You agree to use KAUTO only for lawful purposes. You must not:\n\n• Use the app in any way that violates applicable laws\n• Attempt to gain unauthorized access to any part of the app\n• Use the app to transmit spam or harmful content\n• Impersonate any person or entity\n• Engage in any fraudulent activity',
            ),
            _buildSection(
              '3. Account Responsibility',
              'You are responsible for maintaining the confidentiality of your account credentials. You are responsible for all activities that occur under your account. Please notify us immediately if you suspect any unauthorized use of your account.',
            ),
            _buildSection(
              '4. Products and Pricing',
              'All products listed on KAUTO are subject to availability. Prices are displayed in USD and may change without prior notice. We reserve the right to refuse or cancel any order at our discretion. Product images are for reference only and may slightly differ from the actual product.',
            ),
            _buildSection(
              '5. Payment Terms',
              'By placing an order you agree to pay the full amount including applicable taxes and delivery charges. We accept UPI, Credit/Debit Cards, Net Banking and Cash on Delivery. All payments are processed securely through trusted payment gateways.',
            ),
            _buildSection(
              '6. Cancellation Policy',
              'You may cancel your order before it is shipped. Once shipped, cancellation is not possible. To cancel an order go to My Orders and tap Cancel Order. Refunds for cancelled orders will be processed within 5-7 business days.',
            ),
            _buildSection(
              '7. Return and Refund Policy',
              'We accept returns within 7 days of delivery for damaged or defective products. To initiate a return go to My Orders and tap Return. Refunds will be credited to your original payment method within 7-10 business days after the returned product is received and verified.',
            ),
            _buildSection(
              '8. Intellectual Property',
              'All content on KAUTO including logos, text, images and software is the property of KAUTO and is protected by copyright laws. You may not reproduce, distribute or create derivative works without our written permission.',
            ),
            _buildSection(
              '9. Limitation of Liability',
              'KAUTO shall not be liable for any indirect, incidental or consequential damages arising from the use of our app. Our total liability to you shall not exceed the amount paid for the specific order giving rise to the claim.',
            ),
            _buildSection(
              '10. Changes to Terms',
              'We reserve the right to modify these Terms and Conditions at any time. We will notify you of significant changes through the app or via email. Continued use of the app after changes constitutes acceptance of the new terms.',
            ),
            _buildSection(
              '11. Contact Us',
              'If you have any questions about these Terms and Conditions please contact us:\n\n• github: https://github.com/singhraj09293\n• Phone: +91 9876543210\n• Address: KAUTO Headquarters, Mumbai, Maharashtra, India',
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                '© 2025 KAUTO. All rights reserved.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 15,
            height: 1.6,
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
