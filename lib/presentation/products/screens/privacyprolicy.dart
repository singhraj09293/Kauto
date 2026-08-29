import 'package:flutter/material.dart';
import 'package:kauto/core/theme/apptheme.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
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
              '1. Introduction',
              'Welcome to KAUTO. We are committed to protecting your personal information and your right to privacy. This Privacy Policy explains how we collect, use, and share your information when you use our app.',
            ),
            _buildSection(
              '2. Information We Collect',
              'We collect the following information when you use KAUTO:\n\n• Full name, email address and phone number\n• Delivery address and location\n• Payment information (processed securely)\n• Device information and app usage data\n• Order history and preferences',
            ),
            _buildSection(
              '3. How We Use Your Information',
              'We use the information we collect to:\n\n• Process and deliver your orders\n• Send order confirmations and updates\n• Improve our app and services\n• Send promotional offers (only with your consent)\n• Provide customer support\n• Prevent fraud and ensure security',
            ),
            _buildSection(
              '4. How We Share Your Information',
              'We respect your privacy and do not sell your personal data. Your information may be shared with:\n\n• Delivery partners to fulfill your orders\n• Payment gateways to process transactions securely\n• Legal authorities if required by law\n\nAll third parties are required to keep your data secure and confidential.',
            ),
            _buildSection(
              '5. Data Security',
              'We take data security seriously. Your information is protected using industry-standard encryption and stored on secure servers. We regularly review our security practices to ensure your data is safe.',
            ),
            _buildSection(
              '6. Your Rights',
              'You have the following rights regarding your data:\n\n• Right to access your personal information\n• Right to correct inaccurate data\n• Right to delete your account and data\n• Right to opt out of promotional communications\n• Right to data portability\n\nTo exercise any of these rights, contact us at privacy@kauto.com.',
            ),
            _buildSection(
              '7. Cookies',
              'KAUTO uses cookies and similar tracking technologies to improve your experience. Cookies help us remember your preferences and understand how you use our app. You can disable cookies in your device settings, but this may affect some features of the app.',
            ),
            _buildSection(
              '8. Changes to This Policy',
              'We may update this Privacy Policy from time to time. We will notify you of any significant changes through the app or via email. We encourage you to review this policy periodically to stay informed.',
            ),
            _buildSection(
              '9. Contact Us',
              'If you have any questions or concerns about this Privacy Policy, please contact us:\n\n• github: https://github.com/singhraj09293\n• Address: KAUTO Headquarters, Mumbai, Maharashtra, India',
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
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