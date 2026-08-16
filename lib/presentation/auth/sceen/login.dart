import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kauto/core/theme/apptheme.dart';
import 'package:kauto/presentation/auth/provider/auth_provider.dart';
import 'package:kauto/presentation/auth/sceen/forget_scree.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLogin = true;
  bool issinUp = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.secondary,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Container(
              height: issinUp ? 690 : 600,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black12, offset: Offset(4, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'KAUTO',
                    style: TextStyle(
                      fontSize: 30,
                      color: AppTheme.primary,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Welcome back. Please enter your details.',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() {
                            isLogin = true;
                            issinUp = false;
                          }),
                          child: Column(
                            children: [
                              Text(
                                'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: isLogin
                                      ? AppTheme.primary
                                      : Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 2,
                                color: isLogin
                                    ? AppTheme.primary
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() {
                            isLogin = false;
                            issinUp = true;
                          }),
                          child: Column(
                            children: [
                              Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: !isLogin
                                      ? AppTheme.primary
                                      : Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 2,
                                color: !isLogin
                                    ? AppTheme.primary
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(child: isLogin ? LoginScreen() : SignUp()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool isObscure = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email', style: TextStyle(color: Colors.grey)),
        SizedBox(height: 4),
        TextField(
          controller: email,
          decoration: InputDecoration(
            hintText: 'Enter your Email',
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 20),
        Text('Password', style: TextStyle(color: Colors.grey)),
        SizedBox(height: 4),
        TextField(
          controller: password,
          obscureText: isObscure,
          decoration: InputDecoration(
            hintText: 'Enter your Password',
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ForgetScree()),
                  ),
                  child: Text(
                    'Forget Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: isObscure
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primary,
            padding: EdgeInsets.all(20),
            fixedSize: Size(double.infinity, 63),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
          ),
          onPressed: () {
            try {
              ref
                  .read(authRepositoryProvider)
                  .login(email.text.trim(), password.text.trim());
            } catch (e) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Oops ! ,$e')));
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5),
              Icon(Icons.arrow_forward, color: Colors.white),
            ],
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey)),
            SizedBox(width: 5),
            Text('or continue with'),
            Expanded(child: Divider(color: Colors.grey)),
            SizedBox(width: 5),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                try {
                  ref.read(authRepositoryProvider).signInWithGoogle();
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Oops ! ,$e')));
                }
              },
              child: Container(
                height: 70,
                width: 150,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/google.png',
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Google',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  bool isObscurePass = true;
  bool isObscureCon = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Full Name', style: TextStyle(color: Colors.grey)),
        SizedBox(height: 4),
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter your Full Name',
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 7),
        Text('Email', style: TextStyle(color: Colors.grey)),
        SizedBox(height: 3),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: 'Enter your Email',
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 7),
        Text('Password', style: TextStyle(color: Colors.grey)),
        SizedBox(height: 3),
        TextField(
          controller: passwordController,
          obscureText: isObscurePass,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() => isObscurePass = !isObscurePass);
              },
              icon: isObscurePass
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility),
            ),
            hintText: 'Enter your Password',
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 7),
        Text('Confirm Password', style: TextStyle(color: Colors.grey)),
        SizedBox(height: 3),
        TextField(
          controller: confirmPass,
          onChanged: (value) {
            setState(() {});
          },
          obscureText: isObscureCon,
          decoration: InputDecoration(
            errorText:
                confirmPass.text.isNotEmpty &&
                    confirmPass.text.trim() != passwordController.text.trim()
                ? 'Password does not match'
                : null,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() => isObscureCon = !isObscureCon);
              },
              icon: isObscureCon
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility),
            ),
            hintText: 'Confirm the Password',
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primary,
            padding: EdgeInsets.all(15),
            fixedSize: Size(double.infinity, 63),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(10),
            ),
          ),
          onPressed: () {
            try {
              ref
                  .read(authRepositoryProvider)
                  .signup(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
            } catch (e) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Oops ! ,$e')));
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5),
              Icon(Icons.arrow_forward, color: Colors.white),
            ],
          ),
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey)),
            SizedBox(width: 5),
            Text('or continue with'),
            Expanded(child: Divider(color: Colors.grey)),
            SizedBox(width: 5),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                try {
                  ref.read(authRepositoryProvider).signInWithGoogle();
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Oops ! ,$e')));
                }
              },
              child: Container(
                height: 60,
                width: 150,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/google.png',
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Google',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
