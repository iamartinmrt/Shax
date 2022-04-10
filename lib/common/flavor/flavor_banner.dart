import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'flavor_config.dart';

class FlavorBanner extends StatefulWidget {
  final Widget child;
  final Color? color;

  final BannerLocation? bannerLocation;

  FlavorBanner({required this.child, this.color, this.bannerLocation});

  @override
  _FlavorBannerState createState() => _FlavorBannerState();
}

class _FlavorBannerState extends State<FlavorBanner> {
  late Future<PackageInfo> _future;

  @override
  void initState() {
    _future = PackageInfo.fromPlatform();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if ((FlavorConfig.instance.name.isEmpty)) {
      return widget.child;
    }

    return FutureBuilder<PackageInfo>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Banner(
              color: widget.color ?? Colors.yellow,
              message: 'V: ${snapshot.data!.version}',
              location: widget.bannerLocation ?? BannerLocation.bottomStart,
              child: widget.child,
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 12.0 * 0.85,
                fontWeight: FontWeight.w900,
                height: 1.0,
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
