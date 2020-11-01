import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/corona_service.dart';
import 'app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CoronaSerivce(),
        )
      ],
      child: MyApp(),
    ),
  );
}
