import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../app/di.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import '../view_model/forget_password_view_model.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {

  final ForgetPassViewModel _viewModel =instance<ForgetPassViewModel>();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _areAllInputsValid =TextEditingController();

  final _formKey = GlobalKey<FormState>();
  _bind(){
    _viewModel.start(); // start view model
    _emailController.addListener(() => _viewModel.setEmail(_emailController.text));
  }


  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _areAllInputsValid.dispose();
    _emailController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (BuildContext context,snapshot){
            return snapshot.data?.getScreenWidget(context,_getContentWidget(),(){
              _viewModel.forgetPass();
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
                    stream: _viewModel.outputIsEmailValid,
                    builder: (context,snapshot){
                      return TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _emailController,
                        decoration: InputDecoration(
                            hintText: AppStrings.email.tr(),
                            labelText: AppStrings.email.tr(),
                            errorText:(snapshot.data ?? true) ? null : AppStrings.emailError.tr()
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
                            (snapshot.data ?? false) ? ()=> _viewModel.forgetPass():null
                            ,
                            child: Text(AppStrings.login.tr())),
                      );
                    }
                ),
              ),
            ],
          ),

        ),
      ),

    );
  }
}
