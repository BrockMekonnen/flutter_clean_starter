import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageChangeButton extends StatelessWidget {
  const LanguageChangeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Locale>(
      tooltip: context.tr('layoutPage.changeLanguage'),
      icon: const Icon(Icons.language),
      position: PopupMenuPosition.under,
      onSelected: (locale) => context.setLocale(locale),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: Locale('en'),
          child: Text('English 🇺🇸'),
        ),
        const PopupMenuItem(
          value: Locale('ar'),
          child: Text('العربية 🇸🇦'),
        ),
        const PopupMenuItem(
          value: Locale('zh'),
          child: Text('中文 🇨🇳'),
        ),
        const PopupMenuItem(
          value: Locale('es'),
          child: Text('Español 🇪🇸'),
        ),
      ],
    );
  }
}
