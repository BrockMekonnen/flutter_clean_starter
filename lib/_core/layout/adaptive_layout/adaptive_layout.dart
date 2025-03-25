import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'adaptive_destination.dart';
import 'navigation_type.dart';

typedef NavigationTypeResolver = NavigationType Function(BuildContext context);
const double expandedDrawerWidth = 280;

/// A widget that adapts to the current display size, displaying a [Drawer],
/// [NavigationRail], or [BottomNavigationBar]. Navigation destinations are
/// defined in the [destinations] parameter.
class AdaptiveLayout extends StatelessWidget {
  /// See [Scaffold.appBar].
  final PreferredSizeWidget? appBar;

  /// See [Scaffold.body].
  final Widget body;

  /// See [Scaffold.floatingActionButton].
  final FloatingActionButton? floatingActionButton;

  /// See [Scaffold.floatingActionButtonLocation].
  ///
  /// Ignored if [fabInRail] is true.
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// See [Scaffold.floatingActionButtonAnimator].
  ///
  /// Ignored if [fabInRail] is true.
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  /// See [Scaffold.persistentFooterButtons].
  final List<Widget>? persistentFooterButtons;

  /// See [Scaffold.endDrawer].
  final Widget? endDrawer;

  /// See [Scaffold.drawerScrimColor].
  final Color? drawerScrimColor;

  /// See [Scaffold.backgroundColor].
  final Color? backgroundColor;

  /// See [Scaffold.bottomSheet].
  final Widget? bottomSheet;

  /// See [Scaffold.resizeToAvoidBottomInset].
  final bool? resizeToAvoidBottomInset;

  /// See [Scaffold.primary].
  final bool primary;

  /// See [Scaffold.extendBody].
  final bool extendBody;

  /// See [Scaffold.extendBodyBehindAppBar].
  final bool extendBodyBehindAppBar;

  /// See [Scaffold.drawerEdgeDragWidth].
  final double? drawerEdgeDragWidth;

  /// See [Scaffold.drawerEnableOpenDragGesture].
  final bool drawerEnableOpenDragGesture;

  /// See [Scaffold.endDrawerEnableOpenDragGesture].
  final bool endDrawerEnableOpenDragGesture;

  /// The index into [destinations] for the current selected
  /// [AdaptiveScaffoldDestination].
  final int selectedIndex;

  /// Defines the appearance of the items that are arrayed within the
  /// navigation.
  ///
  /// The value must be a list of two or more [AdaptiveScaffoldDestination]
  /// values.
  final List<AdaptiveDestination> destinations;

  /// Called when one of the [destinations] is selected.
  ///
  /// The stateful widget that creates the adaptive scaffold needs to keep
  /// track of the index of the selected [AdaptiveScaffoldDestination] and call
  /// `setState` to rebuild the adaptive scaffold with the new [selectedIndex].
  final ValueChanged<int>? onDestinationSelected;

  /// Determines the navigation type that the scaffold uses.
  final NavigationTypeResolver? navigationTypeResolver;

  /// The leading item in the drawer when the navigation has a drawer.
  ///
  /// If null, then there is no header.
  final Widget? drawerHeader;

  /// Whether the [floatingActionButton] is inside or the rail or in the regular
  /// spot.
  ///
  /// If true, then [floatingActionButtonLocation] and
  /// [floatingActionButtonAnimation] are ignored.
  final bool fabInRail;

  /// Weather the overflow menu defaults to include overflow destinations and
  /// the overflow destinations.
  final bool includeBaseDestinationsInMenu;

  // final bool isDesktopDrawerExpanded;

  const AdaptiveLayout({
    super.key,
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.endDrawer,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    required this.selectedIndex,
    required this.destinations,
    this.onDestinationSelected,
    this.navigationTypeResolver,
    this.drawerHeader,
    this.fabInRail = true,
    this.includeBaseDestinationsInMenu = true,
    // this.isDesktopDrawerExpanded = true,
  });

  Widget _sideHeader(BuildContext context, void Function()? onMenuPressed,
      [bool isExpanded = false]) {
    return SizedBox(
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(width: 20),
          IconButton(
            onPressed: onMenuPressed,
            icon: Icon(isExpanded ? Icons.menu_open : Icons.menu),
            color: Theme.of(context).appBarTheme.foregroundColor,
            splashRadius: 32,
          ),
          const SizedBox(width: 25),
          // const RemoteSeraLogo(size: 30),
          const SizedBox(width: 5),
          // RemoteSeraName(
          //   fontSize: 16,
          //   color: Theme.of(context).appBarTheme.foregroundColor!,
          // )
        ],
      ),
    );
  }

  Widget _expandedDrawerTile(AdaptiveDestination destination, BuildContext context) {
    bool isSelected = destinations.indexOf(destination) == selectedIndex;
    final navTheme = Theme.of(context).navigationRailTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 2, 10.0, 2),
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: () {
          if (ResponsiveBreakpoints.of(context).isDesktop) {
            Navigator.pop(context);
          }
          _destinationTapped(destination);
        },
        child: Container(
          decoration: BoxDecoration(
            color:
                isSelected ? Theme.of(context).primaryColor.withValues(alpha: 0.3) : null,
            borderRadius: BorderRadius.circular(28),
          ),
          height: 52,
          width: expandedDrawerWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 16),
              if (isSelected) ...[
                Icon(
                  destination.icon,
                  color: navTheme.selectedIconTheme?.color,
                ),
                const SizedBox(width: 12),
                Text(
                  destination.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              ],
              if (!isSelected) ...[
                Icon(
                  destination.icon,
                  color: navTheme.unselectedIconTheme?.color,
                ),
                const SizedBox(width: 12),
                Text(destination.title),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _collapsedDrawerTile(AdaptiveDestination destination, BuildContext context) {
    bool isSelected = destinations.indexOf(destination) == selectedIndex;
    final navTheme = Theme.of(context).navigationRailTheme;

    return Container(
      width: 80,
      height: 56,
      alignment: Alignment.center,
      // margin: const EdgeInsets.all(8),
      child: isSelected
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    color: navTheme.selectedIconTheme!.color!.withOpacity(0.3),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: InkWell(
                    onTap: () => _destinationTapped(destination),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    child: SizedBox(
                      height: 32,
                      width: 56,
                      child: Icon(
                        destination.icon,
                        color: navTheme.selectedIconTheme!.color,
                      ),
                    ),
                  ),
                ),
                Text(
                  destination.title,
                  style: navTheme.selectedLabelTextStyle,
                )
              ],
            )
          : SizedBox(
              height: 32,
              width: 56,
              child: InkWell(
                onTap: () => _destinationTapped(destination),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: Icon(
                  destination.icon,
                  color: navTheme.unselectedIconTheme?.color,
                ),
              ),
            ),
    );
  }

  Widget _buildDrawer({
    required List<AdaptiveDestination> destinations,
    required BuildContext context,
    required bool isExpanded,
    void Function()? onMenuPressed,
  }) {
    if (isExpanded) {
      return SafeArea(
        child: SizedBox(
          width: expandedDrawerWidth,
          child: Material(
            elevation: 3,
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: SafeArea(
              child: ListView(
                children: [
                  _sideHeader(context, onMenuPressed, isExpanded),
                  const SizedBox(height: 10),
                  for (final destination in destinations)
                    _expandedDrawerTile(destination, context),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return SafeArea(
        child: SizedBox(
          width: 80,
          child: SafeArea(
            child: Material(
              elevation: 2,
              color: Theme.of(context).appBarTheme.backgroundColor,
              child: ListView(
                children: [
                  Container(
                    height: 56,
                    width: 80,
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: onMenuPressed,
                      splashRadius: 34,
                      icon: const Icon(Icons.menu),
                      color: Theme.of(context).appBarTheme.foregroundColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  for (final destination in destinations)
                    _collapsedDrawerTile(destination, context)
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Scaffold _buildBottomNavigationScaffold(BuildContext context) {
    final GlobalKey<ScaffoldState> key = GlobalKey();
    const int bottomNavigationOverflow = 5;
    final bottomDestinations = destinations.sublist(
      0,
      math.min(destinations.length, bottomNavigationOverflow),
    );
    bool hasDrawer = destinations.length > bottomNavigationOverflow;
    final drawerDestinations = hasDrawer
        ? destinations
            .sublist(includeBaseDestinationsInMenu ? 0 : bottomNavigationOverflow)
        : <AdaptiveDestination>[];

    return Scaffold(
      key: key,
      body: body,
      appBar: selectedIndex < 5 ? appBar : null,
      drawer: hasDrawer
          ? _buildDrawer(
              destinations: drawerDestinations,
              context: context,
              isExpanded: true,
              onMenuPressed: () => key.currentState!.closeDrawer(),
            )
          : null,
      bottomNavigationBar: selectedIndex < 5
          ? NavigationBar(
              // elevation: 0,
              labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
              destinations: [
                for (final destination in bottomDestinations)
                  NavigationDestination(
                    icon: Icon(destination.icon),
                    label: destination.title,
                  ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected ?? (_) {},
            )
          : null,
      floatingActionButton: floatingActionButton,
    );
  }

  Scaffold _buildNavigationRailScaffold(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final GlobalKey<ScaffoldState> _key = GlobalKey();
    const int railDestinationsOverflow = 7;
    final railDestinations =
        destinations.sublist(0, math.min(destinations.length, railDestinationsOverflow));

    return Scaffold(
      key: _key,
      drawer: _buildDrawer(
        destinations: destinations,
        context: context,
        isExpanded: true,
        onMenuPressed: () => _key.currentState!.closeDrawer(),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDrawer(
            destinations: railDestinations,
            context: context,
            isExpanded: false,
            onMenuPressed: () => _key.currentState!.openDrawer(),
          ),
          const VerticalDivider(width: 0.7, thickness: 0.7),
          Expanded(
            child: Scaffold(
              key: key,
              appBar: appBar,
              body: body,
              floatingActionButton: floatingActionButton,
              floatingActionButtonLocation: floatingActionButtonLocation,
              floatingActionButtonAnimator: floatingActionButtonAnimator,
              persistentFooterButtons: persistentFooterButtons,
              endDrawer: endDrawer,
              bottomSheet: bottomSheet,
              backgroundColor: backgroundColor,
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              primary: true,
              extendBody: extendBody,
              extendBodyBehindAppBar: extendBodyBehindAppBar,
              drawerScrimColor: drawerScrimColor,
              drawerEdgeDragWidth: drawerEdgeDragWidth,
              drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
              endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
            ),
          ),
        ],
      ),
    );
  }

  Scaffold _buildNavigationDrawerScaffold(BuildContext context) {
    final GlobalKey<ScaffoldState> key = GlobalKey(); // Create a key
    return Scaffold(
      key: key,
      body: body,
      appBar: appBar,
      drawer: _buildDrawer(
        destinations: destinations,
        context: context,
        isExpanded: true,
        onMenuPressed: () => key.currentState!.closeDrawer(),
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      persistentFooterButtons: persistentFooterButtons,
      endDrawer: endDrawer,
      bottomSheet: bottomSheet,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      primary: true,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      drawerScrimColor: drawerScrimColor,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
    );
  }

  Scaffold _buildPermanentDrawerScaffold(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // if (state == NavStatus.expanded)
          _buildDrawer(
            destinations: destinations,
            context: context,
            isExpanded: true,
            // onMenuPressed: () => context.read<NavCubit>().changeToCollapsed(),
          ),
          // if (state == NavStatus.collapsed)
          // _buildDrawer(
          //   destinations: destinations,
          //   context: context,
          //   isExpanded: false,
          //   onMenuPressed: () => context.read<NavCubit>().changeToExpanded(),
          // ),
          const VerticalDivider(width: 0.7, thickness: 0.7),
          Expanded(
            child: Scaffold(
              key: key,
              appBar: appBar,
              body: body,
              floatingActionButton: floatingActionButton,
              floatingActionButtonLocation: floatingActionButtonLocation,
              floatingActionButtonAnimator: floatingActionButtonAnimator,
              persistentFooterButtons: persistentFooterButtons,
              endDrawer: endDrawer,
              bottomSheet: bottomSheet,
              backgroundColor: backgroundColor,
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              primary: true,
              extendBody: extendBody,
              extendBodyBehindAppBar: extendBodyBehindAppBar,
              drawerScrimColor: drawerScrimColor,
              drawerEdgeDragWidth: drawerEdgeDragWidth,
              drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
              endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Scaffold build(BuildContext context) {
    final NavigationTypeResolver navigationTypeResolver =
        this.navigationTypeResolver ?? _defaultNavigationTypeResolver;
    var navigationType = navigationTypeResolver(context);
    switch (navigationType) {
      case NavigationType.bottom:
        return _buildBottomNavigationScaffold(context);
      case NavigationType.rail:
        return _buildNavigationRailScaffold(context);
      case NavigationType.drawer:
        return _buildNavigationDrawerScaffold(context);
      case NavigationType.permanentDrawer:
        return _buildPermanentDrawerScaffold(context);
    }
  }

  NavigationType _defaultNavigationTypeResolver(BuildContext context) {
    if (ResponsiveBreakpoints.of(context).smallerThan(TABLET)) {
      return NavigationType.bottom;
    } else if (ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)) {
      return NavigationType.rail;
    } else {
      return NavigationType.permanentDrawer;
    }
  }

  void _destinationTapped(AdaptiveDestination destination) {
    final index = destinations.indexOf(destination);
    if (index != selectedIndex) {
      onDestinationSelected?.call(index);
    }
  }
}
