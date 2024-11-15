import 'package:app/domain/models/user.dart';
import 'package:app/presentation/common/bloc/user_bloc.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:app/presentation/common/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      bloc: GetIt.I<UserBloc>(),
      builder: (context, state) {
        return AppLoader(
          isLoading: !state.isLoggedIn,
          child: CupertinoPageScaffold(
            backgroundColor: CupertinoColors.systemGroupedBackground,
            navigationBar: const CupertinoNavigationBar(
              middle: Text('Profile'),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _UserCard(user: state.user),
                    12.heightBox,
                    CupertinoListSection.insetGrouped(
                      header: const Text('Account Settings'),
                      children: [
                        _SettingsRow(
                          icon: CupertinoIcons.person,
                          label: 'Change Username',
                          value: state.user.username,
                          onTap: () {
                            // TODO: Implement username change
                          },
                        ),
                        _SettingsRow(
                          icon: CupertinoIcons.textformat,
                          label: 'Change Name',
                          value: state.user.name,
                          onTap: () {
                            // TODO: Implement name change
                          },
                        ),
                        _SettingsRow(
                          icon: CupertinoIcons.star,
                          label: 'Change Role',
                          value: state.user.role.name.toUpperCase(),
                          onTap: () {
                            // TODO: Implement role change
                          },
                        ),
                      ],
                    ),
                  ],
                ),
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
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
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
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                4.heightBox,
                Text(
                  '@${user.username}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: CupertinoColors.secondaryLabel,
                  ),
                ),
                4.heightBox,
                Text(
                  user.email,
                  style: const TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.secondaryLabel,
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
          color: CupertinoColors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoFormRow(
      prefix: Icon(
        icon,
        color: CupertinoColors.systemBlue,
        size: 24,
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: CupertinoColors.secondaryLabel,
              ),
            ),
            8.widthBox,
            const Icon(
              CupertinoIcons.chevron_right,
              size: 16,
              color: CupertinoColors.tertiaryLabel,
            ),
          ],
        ),
      ),
    );
  }
}
