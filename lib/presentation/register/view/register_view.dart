import 'dart:io';

import 'package:advanced_flutter_arabic/app/app_preferences.dart';
import 'package:advanced_flutter_arabic/app/constants.dart';
import 'package:advanced_flutter_arabic/app/di.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter_arabic/presentation/register/view_model/register_view_model.dart';
import 'package:advanced_flutter_arabic/presentation/resources/color_manager.dart';
import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../resources/assets_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();
  final AppPreferences _appPreferences =instance<AppPreferences>();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController =TextEditingController();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _passWordController =TextEditingController();
  final TextEditingController _mobileController =TextEditingController();

  _bind(){
    _viewModel.start(); // showing Ui
    _userNameController.addListener(() {_viewModel.setUserName(_userNameController.text); });
    _emailController.addListener(() {_viewModel.setEmail(_emailController.text); });
    _passWordController.addListener(() {_viewModel.setPassword(_passWordController.text); });
    _mobileController.addListener(() {_viewModel.setPhoneNum(_mobileController.text); });

    _viewModel.isUserRegisteredSuccessfullyStreamController.stream.listen((isRegistered) {
      if(isRegistered){
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setUserLoggedIn();
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
      }else{

      }
    });
  }


  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passWordController.dispose();
    _mobileController.dispose();
  super.dispose();
  }



  @override
  Widget build(BuildContext context) {



    Widget _getContentWidget(){
      return Container(
        padding: const EdgeInsets.only(top: AppPadding.p28),
        color: ColorManager.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(child: Image(image: AssetImage(ImagesAssets.splashLogo),),),
                SizedBox(height: AppSize.s18,),
                Padding(
                  padding: EdgeInsets.only(left: AppPadding.p28 , right:AppPadding.p28 ),
                  child: StreamBuilder<String?>(
                      stream: _viewModel.outputErrorUserName,
                      builder: (context,snapshot){
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _userNameController,
                          decoration: InputDecoration(
                              hintText: AppStrings.username.tr(),
                              labelText: AppStrings.username.tr(),
                              errorText:snapshot.data
                          ),
                        );
                      }
                  ),
                ),
                SizedBox(height: AppSize.s18,),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: AppPadding.p28,right: AppPadding.p28),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: ElevatedButton(onPressed: (){
                          showCountryPicker(
                            /*showWorldWide: true,*/
                              showPhoneCode: true,
                              favorite: ['+39','fr'],
                              context: context,
                              onSelect: (country){_viewModel.setCountryCode(country.countryCode);});
                        },child: Text("Select"),),flex: 1,),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.only(left: AppPadding.p28 , right:AppPadding.p28 ),
                            child: StreamBuilder<String?>(
                                stream: _viewModel.outputErrorMobileNumber,
                                builder: (context,snapshot){
                                  return TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller: _mobileController,
                                    decoration: InputDecoration(
                                        hintText: AppStrings.phone.tr(),
                                        labelText: AppStrings.phone.tr(),
                                        errorText:snapshot.data
                                    ),
                                  );
                                }
                            ),
                          ),
                        ),
                      ],
                      
                    ),
                    
                  ),
                ),
                SizedBox(height: AppSize.s18,),
                Padding(
                  padding: EdgeInsets.only(left: AppPadding.p28 , right:AppPadding.p28 ),
                  child: StreamBuilder<String?>(
                      stream: _viewModel.outputErrorEmail,
                      builder: (context,snapshot){
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: InputDecoration(
                              hintText: AppStrings.email.tr(),
                              labelText: AppStrings.email.tr(),
                              errorText:snapshot.data
                          ),
                        );
                      }
                  ),
                ),
                SizedBox(height: AppSize.s18,),
                Padding(
                  padding: EdgeInsets.only(left: AppPadding.p28 , right:AppPadding.p28 ),
                  child: StreamBuilder<String?>(
                      stream: _viewModel.outputErrorPassword,
                      builder: (context,snapshot){
                        return TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passWordController,
                          decoration: InputDecoration(
                              hintText: AppStrings.password.tr(),
                              labelText: AppStrings.password.tr(),
                              errorText:snapshot.data
                          ),
                        );
                      }
                  ),
                ),
                SizedBox(height: AppSize.s18,),
                Padding(
                  padding: EdgeInsets.only(left: AppPadding.p28 , right:AppPadding.p28 ),
                  child: Container(
                    height: AppSize.s40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
                      border: Border.all(color:ColorManager.grey)
                    ),
                    child: GestureDetector(
                      child: _getMediaWidget(),
                      onTap: (){
                        _showPicPicker(context);
                      },
                    ),
                  )
                ),
                SizedBox(height: AppSize.s40,),
                Padding(
                  padding: EdgeInsets.only(left: AppPadding.p28 , right:AppPadding.p28 ),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.areAllInputsValid, // this is is so dummy but i will not change it for now
                      builder: (context,snapshot){
                        return SizedBox(
                          width: double.infinity,
                          height: AppSize.s40,
                          child: ElevatedButton(
                              onPressed:
                              (snapshot.data ?? false) ? ()=> _viewModel.register():null, child: Text(AppStrings.register.tr())),
                        );
                      }
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: AppPadding.p28 , right:AppPadding.p28,top: AppPadding.p18 ),
                  child: TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text(AppStrings.alreadyHaveAccount.tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ],
            ),

          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: AppSize.s0,
        backgroundColor: ColorManager.white,
        iconTheme: IconThemeData(color: ColorManager.primary),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (BuildContext context,snapshot){
          return snapshot.data?.getScreenWidget(context,_getContentWidget(),(){
            _viewModel.register();
          }) ?? _getContentWidget();
        },
      ),
    );


  }
  Widget _getMediaWidget(){
    return Padding(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(AppStrings.profilePic.tr())),
          Flexible(child: StreamBuilder<File>(
            builder: (context , snapshot){
              return _imagePickedByUser(snapshot.data);
            },
            stream: _viewModel.outIsProfilePicValid,
          )),
          Flexible(child: SvgPicture.asset(ImagesAssets.photoCamera))
        ],
      ),
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p8));
  }

  Widget _imagePickedByUser(File? image){
    if(image!=null && image.path.isNotEmpty){
      return Image.file(image) ;
    }else{
      return Container();
    }
  }

  _showPicPicker(BuildContext context){
    showModalBottomSheet(context: context, builder: (context){
      return SafeArea(child: Wrap(
        children: [
          ListTile(
            trailing: Icon(Icons.arrow_forward),
            leading: Icon(Icons.camera),
            title: Text(AppStrings.photoGallery.tr()),
            onTap: (){
              _imageFromGallery();
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward),
            leading: Icon(Icons.camera_alt_outlined),
            title: Text(AppStrings.photoCamera.tr()),
            onTap: (){
              _imageFromCamera();
              Navigator.of(context).pop();
            },
          ),
        ],
      ));
    });
  }

  _imageFromGallery() async {

    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePic(File(image?.path ?? ""));

  }

  _imageFromCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePic(File(image?.path ?? ""));

  }

}
