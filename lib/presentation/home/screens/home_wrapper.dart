import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/common/utils/helpers.dart';
import 'package:app/presentation/common/widgets/tappable.dart';
import 'package:app/presentation/home/bloc/home_bloc.dart';
import 'package:app/presentation/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';

class HomeWrapperScreen extends StatefulWidget {
  const HomeWrapperScreen({super.key});

  @override
  State<HomeWrapperScreen> createState() => _HomeWrapperScreenState();
}

class _HomeWrapperScreenState extends State<HomeWrapperScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      bloc: GetIt.I<HomeBloc>(),
      listenWhen: (previous, current) => previous.pageNr != current.pageNr,
      listener: (context, state) {
        _tabController.animateTo(state.pageNr);
      },
      child: BlocSelector<HomeBloc, HomeState, int>(
        bloc: GetIt.I<HomeBloc>(),
        selector: (state) {
          return state.pageNr;
        },
        builder: (context, pageNr) {
          return Scaffold(
            body: TabBarView(
              controller: _tabController,
              children: const [
                HomeScreen(),
                Text('Search'),
                Text('Tags'),
                Text('Profile'),
              ],
            ),
            bottomNavigationBar: _BuildBottomNavigationBar(
              pageNr: pageNr,
              onTap: (value) {
                GetIt.I<HomeBloc>().changePage(value);
              },
            ),
          );
        },
      ),
    );
  }
}

class _BuildBottomNavigationBar extends StatelessWidget {
  const _BuildBottomNavigationBar({
    required this.pageNr,
    required this.onTap,
  });

  final int pageNr;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      width: double.infinity,
      child: SafeArea(
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _BuildBottomNavigationBarItem(
                  text: 'Home',
                  icon: HugeIcons.strokeRoundedHome11,
                  isSelected: pageNr == 0,
                  onTap: () => AppVibrationFunction(
                    () => onTap(
                      0,
                    ),
                  ),
                ),
                _BuildBottomNavigationBarItem(
                  text: 'Search',
                  icon: HugeIcons.strokeRoundedSearch01,
                  isSelected: pageNr == 1,
                  onTap: () => AppVibrationFunction(
                    () => onTap(1),
                  ),
                ),
                _BuildBottomNavigationBarItem(
                  text: 'Tags',
                  icon: HugeIcons.strokeRoundedTags,
                  isSelected: pageNr == 2,
                  onTap: () => AppVibrationFunction(
                    () => onTap(2),
                  ),
                ),
                _BuildBottomNavigationBarItem(
                  text: 'Profile',
                  icon: HugeIcons.strokeRoundedUser,
                  isSelected: pageNr == 3,
                  onTap: () => AppVibrationFunction(
                    () => onTap(3),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildBottomNavigationBarItem extends StatelessWidget {
  const _BuildBottomNavigationBarItem({
    required this.text,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });
  final IconData icon;
  final String text;
  final bool isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    const kIconSize = 25.0;

    // Make sure GestureDetector is top parent, as it takes all of the button space
    // within bottom nav. Making clickable area very big
    return Tappable.animated(
      onTap: onTap,
      excludeSemantics: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              width: isSelected ? 24 : 0,
              height: 2,
              decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                color: context.colors.dark,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              width: kIconSize,
              height: kIconSize,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  icon,
                  key: ValueKey(icon),
                  size: kIconSize,
                  color:
                      isSelected ? context.colors.primary : context.colors.dark,
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              text,
              style: context.styles.body3.copyWith(
                fontSize: 10,
                color:
                    isSelected ? context.colors.primary : context.colors.dark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
