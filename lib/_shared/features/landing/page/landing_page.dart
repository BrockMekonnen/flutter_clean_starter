import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widgets/language_change_button.dart';
import '../../../widgets/theme_mode_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  void _launchGitHub() async {
    final url = Uri.parse('https://github.com/BrockMekonnen/flutter_clean_starter');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool useRow = ResponsiveBreakpoints.of(context).largerOrEqualTo(DESKTOP);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const FlutterLogo(size: 40),
            if (ResponsiveBreakpoints.of(context).largerOrEqualTo(TABLET)) ...[
              const SizedBox(width: 8),
              Text(
                ' Clean Starter',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ]
          ],
        ),
        actions: [
          IconButton(
            tooltip: context.tr('loginPage.signIn'),
            onPressed: () => context.go("/login"),
            icon: const Icon(Icons.login),
          ),
          const SizedBox(width: 5),
          IconButton(
            tooltip: context.tr('registerPage.signUp'),
            onPressed: () => context.go("/register"),
            icon: const Icon(Icons.person_add),
          ),
          const SizedBox(width: 5),
          ThemeModeButton(radius: 35),
          const SizedBox(width: 5),
          LanguageChangeButton(),
          const SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 900),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 25),
                    Text(
                      "${context.tr('landingPage.welcomeTo')} Flutter Clean Starter",
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    const SizedBox(height: 16),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 700),
                      child: Text(
                        context.tr('landingPage.paragraph1'),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, wordSpacing: 1.5),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 600),
                        child: ResponsiveRowColumn(
                          layout: useRow
                              ? ResponsiveRowColumnType.ROW
                              : ResponsiveRowColumnType.COLUMN,
                          rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                          rowCrossAxisAlignment: CrossAxisAlignment.start,
                          columnCrossAxisAlignment: CrossAxisAlignment.center,
                          columnSpacing: 20,
                          rowSpacing: 10,
                          children: [
                            ResponsiveRowColumnItem(
                              rowFlex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(context.tr('landingPage.featuresTitle'),
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10),
                                  Text(
                                    context.tr('landingPage.featuresDetails'),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            ResponsiveRowColumnItem(
                              rowFlex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(context.tr('landingPage.techStackTitle'),
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10),
                                  Text(
                                    context.tr('landingPage.techStackDetails'),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Align(
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 600),
                        child: ResponsiveRowColumn(
                          layout: useRow
                              ? ResponsiveRowColumnType.ROW
                              : ResponsiveRowColumnType.COLUMN,
                          rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // rowCrossAxisAlignment: CrossAxisAlignment.start,
                          columnCrossAxisAlignment: CrossAxisAlignment.center,
                          columnSpacing: 20,
                          rowSpacing: 10,
                          children: [
                            ResponsiveRowColumnItem(
                              rowFlex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.tr('landingPage.structureTitle'),
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    context.tr('landingPage.structureDetails'),
                                    style: TextStyle(height: 1.5),
                                  ),
                                ],
                              ),
                            ),
                            ResponsiveRowColumnItem(
                              rowFlex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.tr('landingPage.gettingStartedTitle'),
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(context.tr('landingPage.gettingStartedDetails')),
                                ],
                              ),
                            ),
                            // ResponsiveRowColumnItem(child: SizedBox()),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 700),
                      child: Text(
                        context.tr('landingPage.paragraph2'),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: FilledButton.icon(
                        icon: const Icon(Icons.code),
                        label: Text(context.tr('landingPage.viewOnGithub')),
                        onPressed: _launchGitHub,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      context.tr('landingPage.contributionsWelcome'),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      context.tr('landingPage.paragraph3'),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
