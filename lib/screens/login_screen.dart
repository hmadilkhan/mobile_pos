import 'package:flutter/material.dart';
import 'package:mobile_pos/models/user_model.dart';
import 'package:mobile_pos/screens/pos_screen.dart';
import 'package:mobile_pos/services/login_service.dart';
import 'package:mobile_pos/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final UserModel user = UserModel();
  bool isLoggedIn = false;
  LoginService service = LoginService();

  @override
  void initState() {
    super.initState();
    initialLoad();
  }

  void initialLoad() {
    initialData();
  }

  Future<void> initialData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token") ?? "";
    if (token != "") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const PosScreen()));
    }
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = true;
    });

    // var result =
    await service.login(email, password);
    // var chkLoggedIn =  prefs.getBool("isLogedIn");
    // print("Check Logged In State ${chkLoggedIn}");
    // if (result?.name != null) {
    //   setState(() {
    //     isLoggedIn = false;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passController = TextEditingController();

    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 100,
                  height: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  textDirection: TextDirection.ltr,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Log In',
                      style: TextStyle(
                        color: Color(0xFF755DC1),
                        fontSize: 27,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextField(
                      controller: emailController,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Color(0xFF393939),
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Color(0xFF755DC1),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFF837E93),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFF9F7BFF),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: passController,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Color(0xFF393939),
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Color(0xFF755DC1),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFF837E93),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFF9F7BFF),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: SizedBox(
                        width: 329,
                        height: 56,
                        child: isLoggedIn == true
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  login(context, emailController.text,
                                      passController.text);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF9F7BFF),
                                ),
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Don’t have an account?',
                          style: TextStyle(
                            color: Color(0xFF837E93),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          width: 2.5,
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xFF755DC1),
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Forget Password?',
                      style: TextStyle(
                        color: Color(0xFF755DC1),
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        return Scaffold(
          backgroundColor: AppColors.charcoal,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Image.asset(
                        "assets/images/logo.png",
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.width * 0.1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      textDirection: TextDirection.ltr,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            'Log In',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 27,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextField(
                            cursorColor: AppColors.primary,
                            controller: emailController,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: AppColors.primary,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: AppColors.white,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: TextField(
                              cursorColor: AppColors.primary,
                              controller: passController,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 13,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: AppColors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: SizedBox(
                            width: 329,
                            height: 56,
                            child: isLoggedIn == true
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      // loginService.login(
                                      //     emailController.text, passController.text);
                                      login(context, emailController.text,
                                          passController.text);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                    ),
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
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
    });
  }
}
