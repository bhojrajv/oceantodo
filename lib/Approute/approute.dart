import 'package:flutter/material.dart';
import 'package:oceantodo/Stickerview/stickerpg.dart';

class Approute {
  Approute._();
  static Route<dynamic> approute(RouteSettings settings) {
    switch (settings.name) {
      case Nameroute.stcker:
        return MaterialPageRoute(builder: (_) => Stickerpage());

      default:
        return MaterialPageRoute(
            builder: (_) => _UndefinedView(
                  name: settings.name,
                ),
            settings: settings);
    }
  }
}

class _UndefinedView extends StatelessWidget {
  const _UndefinedView({Key? key, this.name}) : super(key: key);
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Something went wrong for $name'),
      ),
    );
  }
}

class Nameroute {
  Nameroute._();
  static const String stcker = "/";
}
