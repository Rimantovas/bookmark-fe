import 'package:app/application/usecases/remove_access_token.dart';
import 'package:app/domain/models/user.dart';
import 'package:app/presentation/common/bloc/user_bloc.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/common/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget _tileIcon(IconData icon, {bool destructive = false}) => Icon(icon,
      size: 24,
      color: destructive
          ? FThemes.zinc.light.colorScheme.destructive
          : FThemes.zinc.light.colorScheme.foreground);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      bloc: GetIt.I<UserBloc>(),
      builder: (context, state) {
        return AppLoader(
          isLoading: !state.isLoggedIn,
          child: FScaffold(
            resizeToAvoidBottomInset: false,
            header: const FHeader(
              title: Text('Profile'),
            ),
            content: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _UserCard(user: state.user),
                  12.heightBox,
                  FTileGroup(
                    label: const Text('Account Settings'),
                    children: [
                      FTile(
                        prefixIcon: _tileIcon(HugeIcons.strokeRoundedUser),
                        title: const Text('Change Username'),
                        details: Text(state.user.username),
                        suffixIcon: FIcon(FAssets.icons.chevronRight),
                        onPress: () {
                          // TODO: Implement username change
                        },
                      ),
                      FTile(
                        prefixIcon: _tileIcon(HugeIcons.strokeRoundedUser),
                        title: const Text('Change Name'),
                        details: Text(state.user.name),
                        suffixIcon: FIcon(FAssets.icons.chevronRight),
                        onPress: () {
                          // TODO: Implement name change
                        },
                      ),
                      FTile(
                        prefixIcon: _tileIcon(HugeIcons.strokeRoundedArrowUp03),
                        title: const Text('Change Role'),
                        details: Text(state.user.role.name.toUpperCase()),
                        suffixIcon: FIcon(FAssets.icons.chevronRight),
                        onPress: () {
                          // TODO: Implement role change
                        },
                      ),
                      FTile(
                        prefixIcon: _tileIcon(HugeIcons.strokeRoundedLogout01,
                            destructive: true),
                        title: Text('Logout',
                            style:
                                TextStyle(color: context.colors.destructive)),
                        suffixIcon: FIcon(
                          FAssets.icons.chevronRight,
                          color: context.colors.destructive,
                        ),
                        onPress: () {
                          RemoveAccessToken().call();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return FCard(
      child: Row(
        children: [
          _UserAvatar(user: user),
          16.widthBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: context.styles.h5.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                4.heightBox,
                Text(
                  '@${user.username}',
                  style: context.styles.body3.copyWith(
                    color: context.colors.primary.withOpacity(0.6),
                  ),
                ),
                Text(
                  user.email,
                  style: context.styles.body3.copyWith(
                    color: context.colors.primary.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar({
    required this.user,
  });

  final User user;

  Color _generateColorFromId() {
    final hash = user.id.hashCode;
    final hue = (hash % 360).toDouble();
    return HSLColor.fromAHSL(1, hue, 0.6, 0.6).toColor();
  }

  String _getInitials() {
    final nameParts = user.name.split(' ');
    if (nameParts.length >= 2) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    }
    return nameParts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    if (user.imageUrl != null) {
      return CircleAvatar(
        radius: 32,
        backgroundImage: NetworkImage(user.imageUrl!),
      );
    }

    return CircleAvatar(
      radius: 32,
      backgroundColor: _generateColorFromId(),
      child: Text(
        _getInitials(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
