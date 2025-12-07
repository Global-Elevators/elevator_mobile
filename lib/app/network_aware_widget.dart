import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:elevator/presentation/resources/values_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NetworkAwareWidget extends StatefulWidget {
  final Widget onlineChild;
  final Widget? offlineChild;

  const NetworkAwareWidget({
    super.key,
    required this.onlineChild,
    this.offlineChild,
  });

  @override
  State<NetworkAwareWidget> createState() => _NetworkAwareWidgetState();
}

class _NetworkAwareWidgetState extends State<NetworkAwareWidget> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      if (!mounted) return;

      final connected =
          results.isNotEmpty && !results.contains(ConnectivityResult.none);

      if (_isOnline != connected) {
        setState(() => _isOnline = connected);
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isOnline
        ? widget.onlineChild
        : widget.offlineChild ?? const _DefaultOfflineScreen();
  }
}

class _DefaultOfflineScreen extends StatelessWidget {
  const _DefaultOfflineScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, size: 80.sp, color: Colors.grey),
              SizedBox(height: AppSize.s20.h),
              Text(
                "You're offline",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: AppSize.s10.h),
              Text(
                "Check your internet connection and try again.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
