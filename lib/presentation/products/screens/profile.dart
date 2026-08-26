import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kauto/core/theme/apptheme.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final currentuser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppTheme.primary.withValues(alpha: 0.7),
                    backgroundImage: currentuser!.photoURL != null
                        ? NetworkImage(currentuser.photoURL!)
                        : null,
                    child: currentuser.photoURL == null
                        ? Text(
                            currentuser.displayName![0],
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 5,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.edit_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              Text(
                currentuser.displayName ?? 'User',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 7),
              Text(
                currentuser.email ?? 'user@gmail.com',
                style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
              ),
              SizedBox(height: 30),
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
                    profileComponents(Icons.inventory_2, 'My order', () {}),
                    SizedBox(height: 10),
                    Divider(color: Colors.grey.shade500, thickness: 0.5),
                    SizedBox(height: 5),
                    profileComponents(
                      Icons.local_shipping,
                      'Shipping Address',
                      () {},
                    ),
                    SizedBox(height: 10),
                    Divider(color: Colors.grey.shade500, thickness: 0.5),
                    SizedBox(height: 5),
                    profileComponents(
                      Icons.credit_card,
                      'Payment Methods',
                      () {},
                    ),
                    SizedBox(height: 10),
                    Divider(color: Colors.grey.shade500, thickness: 0.5),
                    SizedBox(height: 5),
                    profileComponents(Icons.settings, 'Settings', () {}),
                    SizedBox(height: 10),
                    Divider(color: Colors.grey.shade500, thickness: 0.5),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.red.shade100,
                          child: Icon(Icons.logout, color: Colors.red.shade700)),
                        SizedBox(width: 10),
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget profileComponents(IconData icon, String title, VoidCallback onpress) {
  return Row(
    children: [
      CircleAvatar(
        backgroundColor: AppTheme.primary.withValues(alpha: 0.1),
        child: Icon(icon, color: AppTheme.primary)),
      SizedBox(width: 10),
      Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      Spacer(),
      Icon(Icons.chevron_right, color: Colors.grey),
      
    ],
  );
}
