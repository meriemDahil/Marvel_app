import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  Completer<void>? _connectionCompleter;

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

 void _updateConnectionStatus(ConnectivityResult connectivityResult) {
  if (connectivityResult == ConnectivityResult.none) {
    _showNoInternetDialog();
  } else {
    if (_connectionCompleter != null && !_connectionCompleter!.isCompleted) {
      _connectionCompleter!.complete();
      _connectionCompleter = null;
      Get.back(); // Dismiss the dialog
    }
  }
}


  Future<void> waitForConnection() async {
    if (_connectionCompleter != null && !_connectionCompleter!.isCompleted) {
      await _connectionCompleter!.future;
    }
  }

  void _showNoInternetDialog() {
    if (_connectionCompleter == null || _connectionCompleter!.isCompleted) {
      _connectionCompleter = Completer<void>();
      showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false, // Do not allow dismissal
        builder: (context) => AlertDialog(
          title: Text('No Internet'),
          content: Text('Please connect to the internet'),
        ),
      );
    }
  }
}
