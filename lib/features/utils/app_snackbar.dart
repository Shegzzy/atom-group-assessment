import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';


showErrorBar(message){

  toastification.show(
    //context: context,
    type: ToastificationType.error,
    style: ToastificationStyle.flatColored,
    title: Text('Error', style: TextStyle(fontSize: 14, color: Colors.black),),
    description: Text(message, style: TextStyle(fontSize: 14, color: Colors.black),),
    alignment: Alignment.topCenter,
    autoCloseDuration: const Duration(seconds: 5),
    borderRadius: BorderRadius.circular(12.0),
    boxShadow: lowModeShadow,
    showProgressBar: true,
    applyBlurEffect: false,
  );




}

showSuccessBar(message){

  toastification.show(
    //context: context,
    type: ToastificationType.success,
    style: ToastificationStyle.flatColored,
    title: Text('Success', style: TextStyle(fontSize: 14, color: Colors.black),),
    description: Text(message, style: TextStyle(fontFamily: 'SatoMedium', fontSize: 14, color: Colors.black),),
    alignment: Alignment.topCenter,
    autoCloseDuration: const Duration(seconds: 5),
    borderRadius: BorderRadius.circular(12.0),
    boxShadow: lowModeShadow,
    showProgressBar: true,
    applyBlurEffect: false,
  );

}

showInfoBar(message){
  toastification.show(
    //context: context,
    type: ToastificationType.success,
    style: ToastificationStyle.flatColored,
    title: Text('', style: TextStyle(fontFamily: 'SatoSemiBold', fontSize: 14, color: Colors.black),),
    description: Text(message, style: TextStyle(fontFamily: 'SatoMedium', fontSize: 14, color: Colors.black),),
    alignment: Alignment.topCenter,
    autoCloseDuration: const Duration(seconds: 5),
    borderRadius: BorderRadius.circular(12.0),
    boxShadow: lowModeShadow,
    showProgressBar: true,
    applyBlurEffect: false,
  );


}