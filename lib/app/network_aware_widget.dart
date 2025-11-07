import 'dart:async';
import 'package:elevator/data/network/network_info.dart';
import 'package:flutter/material.dart';
import 'package:elevator/app/dependency_injection.dart';
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
  final NetworkInfo _networkInfo = instance<NetworkInfo>();
  late StreamSubscription _subscription;
  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    _checkConnection();
    _subscription = Stream.periodic(const Duration(seconds: 2))
        .asyncMap((_) => _networkInfo.isConnected)
        .listen((connected) {
      if (_isOnline != connected) {
        setState(() => _isOnline = connected);
      }
    });
  }

  Future<void> _checkConnection() async {
    final connected = await _networkInfo.isConnected;
    setState(() => _isOnline = connected);
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
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
                "You’re offline",
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
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: AppSize.s20.h),
              ElevatedButton(
                onPressed: () async {
                  final snackBar = SnackBar(
                    content: const Text("Rechecking connection..."),
                    duration: const Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: const Text("Retry"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
