import 'package:app/domain/enums/user_role.dart';
import 'package:app/presentation/common/bloc/change_role_bloc.dart';
import 'package:app/presentation/common/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class ChangeRoleSheet extends StatefulWidget {
  final UserRole currentRole;

  const ChangeRoleSheet({
    super.key,
    required this.currentRole,
  });

  @override
  State<ChangeRoleSheet> createState() => _ChangeRoleSheetState();
}

class _ChangeRoleSheetState extends State<ChangeRoleSheet> {
  late UserRole _selectedRole;
  final _bloc = ChangeRoleBloc();

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.currentRole;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.theme.colorScheme.background,
          border: Border(
            top: BorderSide(color: context.theme.colorScheme.border),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 16, 24.0, 0.0),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: context.colors.foreground,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                16.heightBox,
                Text(
                  'Change Role',
                  style: context.theme.typography.xl2.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.theme.colorScheme.foreground,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Select your preferred role in the application.',
                  style: context.theme.typography.sm.copyWith(
                    color: context.theme.colorScheme.mutedForeground,
                  ),
                ),
                const SizedBox(height: 24),
                FRadio(
                  value: _selectedRole == UserRole.regular,
                  label: const Text('Regular'),
                  description: const Text('Access to basic features'),
                  onChange: (value) {
                    if (value) {
                      setState(() => _selectedRole = UserRole.regular);
                      _handleRoleChange();
                    }
                  },
                ),
                const SizedBox(height: 12),
                FRadio(
                  value: _selectedRole == UserRole.premium,
                  label: const Text('Premium'),
                  description: const Text('Access to advanced features'),
                  onChange: (value) {
                    if (value) {
                      setState(() => _selectedRole = UserRole.premium);
                      _handleRoleChange();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleRoleChange() async {
    if (_selectedRole != widget.currentRole) {
      final success = await _bloc.changeRole(_selectedRole);
      if (success && mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}
