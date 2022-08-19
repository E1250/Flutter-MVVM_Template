import 'package:advanced_flutter_arabic/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/color_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/styles_manager.dart';
import 'package:advanced_flutter_arabic/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../data/network/failure.dart';
import '../../resources/font_manager.dart';

enum StateRendererType{
  // Popup states (Dialog)
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,
  POPUP_SUCCESS,

  // Full screen states (Full Screen)
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,
  FULL_SCREEN_EMPTY_STATE,

  // General
  CONTENT_STATE


}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryActionFunction;
  /* Failure? failure; */

  StateRenderer({required this.stateRendererType,this.message=AppStrings.loading,this.title="",required this.retryActionFunction});

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context){

    switch(stateRendererType) {
      case StateRendererType.POPUP_LOADING_STATE:
        return _getPopupDialog(context,[_getAnimatedImage(JsonAssets.loading)]);

      case StateRendererType.POPUP_ERROR_STATE:
        return _getPopupDialog(context,[
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.retryAgain.tr(),context)
        ]);

      case StateRendererType.FULL_SCREEN_LOADING_STATE:
      return _getItemsColumn([
        _getAnimatedImage(JsonAssets.loading),
        _getMessage(message),
      ]);

      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        return _getItemsColumn([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.retryAgain.tr(),context)
        ]);

      case StateRendererType.FULL_SCREEN_EMPTY_STATE:
        return _getItemsColumn([
          _getAnimatedImage(JsonAssets.empty),
          _getMessage(message)
        ]);
      case StateRendererType.CONTENT_STATE:
        return Container();

      case StateRendererType.POPUP_SUCCESS:
        return _getPopupDialog(context, [
          _getAnimatedImage(JsonAssets.success),
          _getMessage(title),
          _getMessage(message),
          _getRetryButton(AppStrings.ok.tr(), context)

        ]);
      default:
        return Container();
    }
  }

  Widget _getPopupDialog(BuildContext context,List<Widget> children){
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s14)),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: const [BoxShadow(
            color: Colors.black26
          )],
        ),
        child: _getDialogContent(context,children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context,List<Widget> children){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
  Widget _getItemsColumn(List<Widget> children){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
  Widget _getAnimatedImage(String animationName){
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName), // todo add json image here
    );
  }
  Widget _getMessage(String message){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(message,style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s18)),
      ),
    );
  }
  Widget _getRetryButton(String buttonTitle,BuildContext context){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(width: double.infinity,child: ElevatedButton(
            onPressed: (){
              if(stateRendererType == StateRendererType.FULL_SCREEN_ERROR_STATE){
                retryActionFunction.call();
              }else{ // popup error state
                return Navigator.of(context).pop();
              }
        }, child: Text(buttonTitle))),
      ),
    );
  }
}
