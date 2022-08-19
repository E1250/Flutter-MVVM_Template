import 'package:advanced_flutter_arabic/app/constants.dart';
import 'package:advanced_flutter_arabic/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter_arabic/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

abstract class FlowState{
  StateRendererType getStateRenderedType();
  String getMessage();

}

// loading state (popup , full screen)

class LoadingState extends FlowState{
  StateRendererType stateRendererType;
  String? message;

  LoadingState({required this.stateRendererType,String message = AppStrings.loading});

  @override
  String getMessage() => message ?? AppStrings.loading.tr();

  @override
  StateRendererType getStateRenderedType() => stateRendererType;


}

// loading state (popup , full screen)
class ErrorState extends FlowState{
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType,this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRenderedType() => stateRendererType;


}

// content state
class ContentState extends FlowState{
  ContentState();

  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRenderedType() => StateRendererType.CONTENT_STATE;

}

// Empty state
class EmptyState extends FlowState{
  String message;
  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRenderedType() => StateRendererType.FULL_SCREEN_EMPTY_STATE;

}


// Success state
class SuccessState extends FlowState{
  String message;
  SuccessState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRenderedType() => StateRendererType.POPUP_SUCCESS;

}


extension FlowStateExtention on FlowState{
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,Function retryActionFunction){
    switch(runtimeType){ //  return current state
      case LoadingState:{
        if(getStateRenderedType() == StateRendererType.POPUP_LOADING_STATE){
          // show popup loading
          // show content of the screen
          showPopUp(context, getStateRenderedType(), getMessage());
          return contentScreenWidget;
        }else{
          // full screen state loading
          return StateRenderer(stateRendererType: getStateRenderedType(),message: getMessage(), retryActionFunction: retryActionFunction);
        }
      }
      case ErrorState:{
        _dismissDialog(context);
        if(getStateRenderedType() == StateRendererType.POPUP_ERROR_STATE){
          // show popup error
          // show content of the screen
          showPopUp(context, getStateRenderedType(), getMessage());
          return contentScreenWidget;
        }else{
          // full screen state loading
          return StateRenderer(stateRendererType: getStateRenderedType(),message: getMessage(), retryActionFunction: retryActionFunction);

        }
      }
      case EmptyState:{
        return StateRenderer(stateRendererType: getStateRenderedType(), retryActionFunction: (){},message: getMessage(),);
      }
      case ContentState:{
        _dismissDialog(context);
        return contentScreenWidget;
      }
      case SuccessState:{
        _dismissDialog(context);
        showPopUp(context, StateRendererType.POPUP_SUCCESS, getMessage(),title: AppStrings.success.tr());
        return contentScreenWidget;
      }
      default:{
        _dismissDialog(context);
        return contentScreenWidget;
      }
    }
  }

  _isCurrentDialogShowing(BuildContext context)=> ModalRoute.of(context)?.isCurrent != true;
  _dismissDialog(BuildContext context){
    if(_isCurrentDialogShowing(context)){
      Navigator.of(context,rootNavigator: true).pop(true);
    }
  }

  showPopUp(BuildContext context,StateRendererType stateRendererType,String message,{String title = Constants.empty}){
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(context: context, builder: (BuildContext context)=> StateRenderer(stateRendererType: stateRendererType,message: message, retryActionFunction: (){})));
  }
}