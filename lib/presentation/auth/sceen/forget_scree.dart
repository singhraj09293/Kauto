import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kauto/core/theme/apptheme.dart';
import 'package:kauto/presentation/auth/provider/auth_provider.dart';

class ForgetScree extends ConsumerWidget {
  const ForgetScree({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController email = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'KAUTO',
          style: TextStyle(color: AppTheme.primary, letterSpacing: 0.5),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email', style: TextStyle(color: Colors.grey)),
                SizedBox(height: 10),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: 'Enter email',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 100),
                Image.asset('assets/images/forget.png', fit: BoxFit.fill),
                SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      padding: EdgeInsets.all(20),
                      fixedSize: Size(double.infinity, 63),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                    ),
                    onPressed: () {
                      ref
                          .read(authRepositoryProvider)
                          .forgetPass(email.text.trim());
                      email.text.isNotEmpty
                          ? ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    Text('check your Mail'),
                                    SizedBox(width: 5),
                                    Icon(Icons.mail, color: Colors.white),
                                  ],
                                ),
                              ),
                            )
                          : null;
                      Future.delayed(Duration(seconds: 5), () {
                        Navigator.pop(context);
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Send',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.send, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
