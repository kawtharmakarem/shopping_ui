import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/features/home/presentation/screens/pages/women_page.dart';

import '../../../../core/resources/color_manager.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/CustomBottomNav.dart';
import 'pages/kids_page.dart';
import 'pages/men_pages.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final List<Widget> pages = [WomenPage(), MenPage(), KidsPage()];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        return Scaffold(
          backgroundColor: AppColors.grey,
          body: pages[cubit.selectedIndex],

          bottomNavigationBar: AnimatedBottomNavigation(),
        );
      },
    );
  }
}
