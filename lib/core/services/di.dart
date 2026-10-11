import 'package:get_it/get_it.dart';

import '../../features/home/presentation/cubit/home_cubit.dart';

final getIt = GetIt.instance;
void setUpLocator() {
  getIt.registerLazySingleton(() => HomeCubit());
}
