import 'package:flutter/material.dart';
import 'package:kauto/core/theme/apptheme.dart';
import 'package:kauto/presentation/products/screens/comingsoonscreen.dart';
import 'package:kauto/presentation/products/screens/helpcenter.dart';
import 'package:kauto/presentation/products/screens/privacyprolicy.dart';
import 'package:kauto/presentation/products/screens/termsofservice.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setting',
          style: TextStyle(
            color: AppTheme.primary,
            fontSize: 25,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ACCOUNT AND SETTINGS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      offset: Offset(0, 4),
                      blurRadius: 10,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ComingSoonScreen(
                            title: 'Password And Security Coming Soon',
                          ),
                        ),
                      ),
                      child: settingComponents(
                        Icons.lock,
                        'Password & Security',
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(color: Colors.grey.shade500, thickness: 0.5),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ComingSoonScreen(title: 'Payments'),
                        ),
                      ),
                      child: settingComponents(
                        Icons.payment,
                        'Payment Methods',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Text(
                'PREFERENCES',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      offset: Offset(0, 4),
                      blurRadius: 10,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    settingComponents(
                      Icons.notifications_outlined,
                      'Notifications',
                    ),
                    SizedBox(height: 10),
                    Divider(color: Colors.grey.shade500, thickness: 0.5),
                    SizedBox(height: 5),
                    lanappComponents(Icons.language, 'Language', 'English'),
                    SizedBox(height: 10),
                    Divider(color: Colors.grey.shade500, thickness: 0.5),
                    SizedBox(height: 5),
                    lanappComponents(Icons.brightness_6, 'Apperance', 'Light'),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Text(
                'SUPPORT & LEGAL',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      offset: Offset(0, 4),
                      blurRadius: 10,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => HelpCenter()),
                      ),
                      child: settingComponents(
                        Icons.help_outline,
                        'Help Center',
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(color: Colors.grey.shade500, thickness: 0.5),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => PrivacyPolicy()),
                      ),
                      child: settingComponents(
                        Icons.policy_outlined,
                        'Privacy Policy',
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(color: Colors.grey.shade500, thickness: 0.5),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: ()=>Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TermsConditions()),
                      ),
                      child: settingComponents(
                        Icons.description_outlined,
                        'Terms of Service',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}

Widget settingComponents(IconData icon, String title) {
  return Row(
    children: [
      Icon(icon, color: Colors.black),
      SizedBox(width: 10),
      Text(title, style: TextStyle(fontSize: 18)),
      Spacer(),
      Icon(Icons.chevron_right, color: Colors.grey),
    ],
  );
}

Widget lanappComponents(IconData icon, String title, String text) {
  return Row(
    children: [
      Icon(icon, color: Colors.black),
      SizedBox(width: 10),
      Text(title, style: TextStyle(fontSize: 18)),
      Spacer(),
      Text(text, style: TextStyle(color: Colors.grey, fontSize: 18)),
      Icon(Icons.chevron_right, color: Colors.grey),
    ],
  );
}
