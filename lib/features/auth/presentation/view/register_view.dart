import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/common/snackbar/my_snackbar.dart';
import '../viewmodel/auth_view_model.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final _gap = const SizedBox(height: 8);

  final _key = GlobalKey<FormState>();
  final _fnameController = TextEditingController(text: 'aasif');
  final _lnameController = TextEditingController(text: 'manandhar');
  final _phoneController = TextEditingController(text: '9812345670');
  final _usernameController = TextEditingController(text: 'aasif');
  final _passwordController = TextEditingController(text: 'aasif123');
  bool isObscure = true;

  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future<void> _browseImage(WidgetRef ref, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 235, 240),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: SizedBox(
              width: 120,
              height: 100,
              child: CustomPaint(
                painter: TrianglePainter(
                  color: const Color.fromARGB(217, 119, 195, 207),
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.grey[300],
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder: (context) => Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        _browseImage(ref, ImageSource.camera);
                                        Navigator.pop(context);
                                        // Upload image if it is not null
                                      },
                                      icon: const Icon(Icons.camera),
                                      label: const Text('Camera'),
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        _browseImage(ref, ImageSource.gallery);
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.image),
                                      label: const Text('Gallery'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            height: 200,
                            width: 200,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: _img != null
                                  ? FileImage(_img!)
                                  : const AssetImage('assets/images/user.png')
                                      as ImageProvider,
                            ),
                          ),
                        ),
                        _gap,
                        TextFormField(
                          controller: _fnameController,
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter first name';
                            }
                            return null;
                          },
                        ),
                        _gap,
                        TextFormField(
                          controller: _lnameController,
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter last name';
                            }
                            return null;
                          },
                        ),
                        _gap,
                        TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Phone No',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter phoneNo';
                            }
                            return null;
                          },
                        ),
                        _gap,
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter username';
                            }
                            return null;
                          },
                        ),
                        _gap,
                        TextFormField(
                          controller: _passwordController,
                          obscureText: isObscure,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                        ),
                        _gap,
                        SizedBox(
                          width: double.infinity,
                          child: SizedBox(
                            width: 350,
                            height: 70,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_key.currentState!.validate()) {
                                  final authStateNotifier =
                                      ref.read(authViewModelProvider.notifier);
                                  authStateNotifier.registerUser(
                                    fname: _fnameController.text,
                                    lname: _lnameController.text,
                                    phone: _phoneController.text,
                                    username: _usernameController.text,
                                    password: _passwordController.text,
                                    image: authState.imageName ?? '',
                                  );

                                  if (authState.error != null) {
                                    showSnackBar(
                                      message: authState.error.toString(),
                                      context: context,
                                      color: Colors.red,
                                    );
                                  } else {
                                    showSnackBar(
                                      message: 'Registered successfully',
                                      context: context,
                                    );
                                  }
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 27, 206, 200),
                                ),
                              ),
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/loginRoute');
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 27, 206, 200),
                                ),
                              ),
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, 0);
    path.close();

    final paint = Paint()..color = color;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) => false;
}
