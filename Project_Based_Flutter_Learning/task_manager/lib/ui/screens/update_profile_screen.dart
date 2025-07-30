import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart' as _emailTEController;
import 'package:task_manager/ui/screens/update_profile_screen.dart' as _firstNameTEController;
import 'package:task_manager/ui/screens/update_profile_screen.dart' as _lastNameTEController;
import 'package:task_manager/ui/screens/update_profile_screen.dart' as _phoneTEController;
import 'package:task_manager/ui/screens/update_profile_screen.dart' as _passwordTEController;
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/screen_bagground.dart';
import 'package:task_manager/ui/widgets/snackbar_message.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';


class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});
  static const String name = '/update-profile';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;
  bool _updateProfileInProgress = false;
  @override
  void initState() {
    super.initState();
    _emailTEController.text = AuthController.userModel?.email ?? '';
    _firstNameTEController.text = AuthController.userModel?.firstName ?? '';
    _lastNameTEController.text = AuthController.userModel?.lastName ?? '';
    _phoneTEController.text = AuthController.userModel?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TaskManagerAppBar(),
      body: ScreenBagground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 80),
                  Center(
                    child: Text(
                      'Update Profile',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(height: 25),
                  _buildPhotoPicker(),

                  SizedBox(height: 8),
                  TextFormField(
                    controller: _emailTEController,
                    textInputAction: TextInputAction.next,
                    enabled: false,
                    // decoration: InputDecoration(hintText: 'Email'),
                    // validator: (String?value){
                    //   if(value?.isEmpty ?? true){
                    //     return 'Enter a valid email';
                    //   }
                    //   return null;
                    // },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _firstNameTEController,
                    textInputAction: TextInputAction.next,
                    // obscureText: true,
                    decoration: InputDecoration(hintText: 'First name'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter Your First Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _lastNameTEController,
                    textInputAction: TextInputAction.next,
                    // obscureText: true,
                    decoration: InputDecoration(hintText: 'Last name'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter Your Last Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _phoneTEController,
                    textInputAction: TextInputAction.next,
                    // obscureText: true,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Mobile number'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter Your Mobile number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Password'),
                    validator: (String? value) {
                      int length = value?.length ?? 0;
                      if (length > 0 && length <= 6) {
                        return 'Enter a password more than 6 letters .';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  Visibility(
                    visible: _updateProfileInProgress == false,
                    replacement: CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapSubmitButton,
                      child: Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoPicker() {
    return GestureDetector(
      onTap: _onTapPhotoPicker,
      child: Container(
        height: 50,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'photo',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _selectedImage == null ? 'Select Image' : _selectedImage!.name,
              maxLines: 1,
              style: TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapPhotoPicker() async {
    final XFile? pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      _selectedImage = pickedImage;
      setState(() {});
    }
  }

  void _onTapSubmitButton() {
    if (_formkey.currentState!.validate()) {
      _updateProfile();
    }
  }

  Future<void> _updateProfile() async {
    _updateProfileInProgress = true;
    if (mounted) {
      setState(() {});
    }

    //Uint8List? imageBytes;

    Map<String, String> requestBody = {
      "email": _emailTEController.text,
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _phoneTEController.text.trim(),
     // "photo":""
    };
    if (_passwordTEController.text.isNotEmpty) {
      requestBody['password'] = _passwordTEController.text;
    }
    if (_selectedImage != null) {
     Uint8List imageBytes = await _selectedImage!.readAsBytes();
      requestBody['photo'] = base64Encode(imageBytes);
    }

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.updateProfileUrl,
      body: requestBody,
    );
    _updateProfileInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      _passwordTEController.clear();
      if(mounted){
        showSnackBarMessage(context, 'Profile updated');
      }

    }else{
      if(mounted){
        showSnackBarMessage(context, response.errorMessage!);
      }

    }

      // UserModel userModel = UserModel(
      //   id: AuthController.userModel!.id,
      //   email: _emailTEController.text,
      //   firstName: _firstNameTEController.text.trim(),
      //   lastName: _lastNameTEController.text.trim(),
      //   mobile: _phoneTEController.text.trim(),
      //   photo:
      //       imageBytes == null
      //           ? AuthController.userModel?.photo
      //           : base64Encode(imageBytes)
      // );

    //   await AuthController.updateUserData(userModel,AuthController.accessToken ?? '');
    //
    //   _passwordTEController.clear();
    //   if (mounted) {
    //     showSnackBarMessage(context, 'Profile Update');
    //   }
    // } else {
    //   if (mounted) {
    //     showSnackBarMessage(context, 'Profile Update');
    //   }
    }


  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _phoneTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
