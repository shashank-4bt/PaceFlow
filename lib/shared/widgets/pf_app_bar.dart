import 'package:flutter/material.dart';

import 'package:paceflow/app/theme/app_spacings.dart';
import 'package:paceflow/shared/widgets/glass_container.dart';

class PfAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PfAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.glass = false,
    this.centerTitle = true,
  });

  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool glass;
  final bool centerTitle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + AppSpacings.sm);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      leading: leading,
      actions: actions,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );

    if (!glass) return appBar;

    return PreferredSize(
      preferredSize: preferredSize,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacings.md),
          child: GlassContainer(
            padding: EdgeInsets.zero,
            borderRadius: AppSpacings.borderRadiusLg,
            child: appBar,
          ),
        ),
      ),
    );
  }
}
