import 'package:advanced_flutter_arabic/app/di.dart';
import 'package:advanced_flutter_arabic/data/data_source/remote_data_source.dart';
import 'package:advanced_flutter_arabic/data/repository/repository_impl.dart';
import 'package:advanced_flutter_arabic/domain/repository/repository.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter_arabic/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:advanced_flutter_arabic/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/color_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../app/app_preferences.dart';
import '../../resources/routes_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {


  /*RemoteDataSource _remoteDataSource = RemoteDataSourceImpl(appServiceClient);
  Repository _repository = RepositoryImpl(_remoteDataSource, _networkInfo);
  LoginUseCase _loginUseCase =LoginUseCase(_repository);*/


  final LoginViewModel _viewModel =instance<LoginViewModel>();
  final TextEditingController _userNameController =TextEditingController();
  final TextEditingController _passwordController =TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _bind(){
    _viewModel.start(); // start view model
    _userNameController.addListener(() => _viewModel.setUserName(_userNameController.text));
    _passwordController.addListener(() => _viewModel.setPassword(_passwordController.text));
    _viewModel.isUserLoggedInStreamController.stream.listen((isLoggedIn) {
      if(isLoggedIn){
        // navigate to main screen
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
    super.dispose(); // this to call super function in base view model
    _viewModel.dispose();
   _userNameController.dispose();
   _passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (BuildContext context,snapshot){
          return snapshot.data?.getScreenWidget(context,_getContentWidget(),(){
            _viewModel.login();
          }) ?? _getContentWidget();
        },
      )
    );
  }

  Widget _getContentWidget(){
    return Container(
        padding: const EdgeInsets.only(top: AppPadding.p100),
        color: ColorManager.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
               children: [
                 Center(child: Image(image: AssetImage(ImagesAssets.splashLogo),),),
                 SizedBox(height: AppSize.s28,),
                 Padding(
                   padding: EdgeInsets.only(left: AppPadding.p28 , right:AppPadding.p28 ),
                   child: StreamBuilder<bool>(
                       stream: _viewModel.outputIsUserNameValid,
                       builder: (context,snapshot){
                         return TextFormField(
                           keyboardType: TextInputType.emailAddress,
                           controller: _userNameController,
                           decoration: InputDecoration(
                             hintText: AppStrings.username.tr(),
                             labelText: AppStrings.username.tr(),
                             errorText:(snapshot.data ?? true) ? null : AppStrings.usernameError.tr()
                           ),
                         );
                       }
                   ),
                 ),
                 SizedBox(height: AppSize.s28,),
                 Padding(
                   padding: EdgeInsets.only(left: AppPadding.p28 , right:AppPadding.p28 ),
                   child: StreamBuilder<bool>(
                       stream: _viewModel.outputIsPasswordValid,
                       builder: (context,snapshot){
                         return TextFormField(
                           keyboardType: TextInputType.visiblePassword,
                           controller: _passwordController,
                           decoration: InputDecoration(
                               hintText: AppStrings.password.tr(),
                               labelText: AppStrings.password.tr(),
                               errorText:(snapshot.data ?? true) ? null : AppStrings.passwordError.tr()
                           ),
                         );
                       }
                   ),
                 ),
                 SizedBox(height: AppSize.s28,),
                 Padding(
                   padding: EdgeInsets.only(left: AppPadding.p28 , right:AppPadding.p28 ),
                   child: StreamBuilder<bool>(
                       stream: _viewModel.areAllOutputsValid, // this is is so dummy but i will not change it for now
                       builder: (context,snapshot){
                         return SizedBox(
                           width: double.infinity,
                           height: AppSize.s40,
                           child: ElevatedButton(
                               onPressed:
                              (snapshot.data ?? false) ? ()=> _viewModel.login():null


                           ,
                               child: Text(AppStrings.login.tr())),
                         );
                       }
                   ),
                 ),
                 Padding(
                     padding: const EdgeInsets.only(left: AppPadding.p28,right: AppPadding.p28,top: AppPadding.p8),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       TextButton(
                           onPressed: (){
                             Navigator.pushNamed(context, Routes.forgotPasswordRoute);
                           },
                           child: Text(
                             AppStrings.forgetPassword.tr(),
                             style: Theme.of(context).textTheme.titleMedium,
                             textAlign: TextAlign.end,
                           ),
                       ),
                       TextButton(
                         onPressed: (){
                           Navigator.pushNamed(context, Routes.registerRoute);
                         },
                         child: Text(
                           AppStrings.registerText.tr(),
                           style: Theme.of(context).textTheme.titleMedium,
                           textAlign: TextAlign.end,
                         ),
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
