import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/resources/routes_manager.dart';
import 'core/services/di.dart';
import 'features/home/presentation/cubit/home_cubit.dart';

void main() {
  setUpLocator();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp._internal();
  static final MyApp _instance = MyApp._internal();
  factory MyApp() => _instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>(),
      child: MaterialApp(
        title: 'SpringCollection',
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        //home: CustomDraggableSliverPage(),
        initialRoute: Routes.splashRoute,
        onGenerateRoute: RouteGenerator.getRoute,
      ),
    );
  }
}

/**app/build.gradle
  compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }
    lint {
        baseline = file("lint-baseline.xml")
    }

    flutter {
    source = "../.."
}
 
   dependencies{
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}

 */

/**
 * android/gradle.properties
 
 kotlin.incremental=false
kotlin.daemon.useFallbackStrategy=true
kotlin.incremental.useClasspathSnapshot=false
 */

/**
 * flutter clean
flutter pub cache repair
gradlew --stop
gradlew clean
 */
