import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../_core/app_router.dart';

class LanguageChangeButton extends StatelessWidget {
  const LanguageChangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: context.tr('layoutPage.changeLanguage'),
      icon: const Icon(Icons.language),
      onPressed: () async {
        final RenderBox button = context.findRenderObject() as RenderBox;
        final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
        final Offset offset = button.localToGlobal(Offset.zero, ancestor: overlay);

        final Locale? selected = await showMenu<Locale>(
          context: context,
          position: RelativeRect.fromLTRB(
            offset.dx,
            offset.dy + button.size.height,
            overlay.size.width - offset.dx - 15,
            0,
          ),
          items: const [
            PopupMenuItem(
              value: Locale('en'),
              child: Text('English 🇺🇸'),
            ),
            PopupMenuItem(
              value: Locale('ar'),
              child: Text('العربية 🇸🇦'),
            ),
            PopupMenuItem(
              value: Locale('zh'),
              child: Text('中文 🇨🇳'),
            ),
            PopupMenuItem(
              value: Locale('es'),
              child: Text('Español 🇪🇸'),
            ),
          ],
        );

        if (selected != null) {
          // Defer locale change after frame render to avoid context issues
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final safeContext = rootNavigatorKey.currentContext;
            if (safeContext != null) {
              safeContext.setLocale(selected);
            }
          });
        }
      },
    );
  }
}