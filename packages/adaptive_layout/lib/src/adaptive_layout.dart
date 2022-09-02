import 'dart:math' as math;

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

typedef NavigationTypeResolver = NavigationType Function(BuildContext context);

// The navigation mechanism to configure the [Scaffold] with.
enum NavigationType {
  // Used to configure a [Scaffold] with a [BottomNavigationBar].
  bottom,

  // Used to configure a [Scaffold] with a [NavigationRail].
  rail,

  // Used to configure a [Scaffold] with a modal [Drawer].
  drawer,

  // Used to configure a [Scaffold] with an always open [Drawer].
  permanentDrawer,
}

/// Used to configure items or destinations in the various navigation
/// mechanism. For [BottomNavigationBar], see [BottomNavigationBarItem]. For
/// [NavigationRail], see [NavigationRailDestination]. For [Drawer], see
/// [ListTile].
class AdaptiveDestination {
  final String title;
  final IconData icon;

  AdaptiveDestination({required this.title, required this.icon});
}

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
    Key? key,
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
  }) : super(key: key);

  NavigationType _defaultNavigationTypeResolver(BuildContext context) {
    if (ResponsiveWrapper.of(context).isMobile) {
      return NavigationType.bottom;
    } else if (ResponsiveWrapper.of(context).isTablet ||
        ResponsiveWrapper.of(context).equals('MOBILE_LARGE')) {
      return NavigationType.rail;
    } else {
      return NavigationType.permanentDrawer;
    }
  }

  Drawer _defaultDrawer(
      List<AdaptiveDestination> destinations, BuildContext context) {
    return Drawer(
      width: 230,
      child: ListView(
        children: [
          if (drawerHeader != null) drawerHeader!,
          const Divider(thickness: 0.9, height: 0.7),
          for (int i = 0; i < destinations.length; i++)
            ListTile(
              leading:
                  this.destinations.indexOf(destinations[i]) == selectedIndex
                      ? Icon(
                          destinations[i].icon,
                          size: 28,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : Opacity(
                          opacity: 0.8,
                          child: Icon(
                            destinations[i].icon,
                            color: Theme.of(context)
                                .navigationRailTheme
                                .unselectedIconTheme
                                ?.color,
                          ),
                        ),
              title: this.destinations.indexOf(destinations[i]) == selectedIndex
                  ? Text(
                      destinations[i].title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  : Text(
                      destinations[i].title,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
              onTap: () {
                Navigator.pop(context);
                _destinationTapped(destinations[i]);
              },
            )
        ],
      ),
    );
  }

  Scaffold _buildBottomNavigationScaffold(BuildContext context) {
    const int bottomNavigationOverflow = 5;
    final bottomDestinations = destinations.sublist(
      0,
      math.min(destinations.length, bottomNavigationOverflow),
    );
    final drawerDestinations = destinations.length > bottomNavigationOverflow
        ? destinations.sublist(
            includeBaseDestinationsInMenu ? 0 : bottomNavigationOverflow)
        : <AdaptiveDestination>[];
    // bool isSelected = destinations.indexOf(destination) == selectedIndex;
    return Scaffold(
      key: key,
      body: body,
      appBar: selectedIndex < 5 ? appBar : null,
      drawer: drawerDestinations.isEmpty
          ? null
          : _defaultDrawer(drawerDestinations, context),
      bottomNavigationBar: selectedIndex < 5
          ? CustomNavigationBar(
              iconSize: 24,
              selectedColor:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
              unSelectedColor: Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedItemColor,
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
                      Theme.of(context).backgroundColor,
              items: [
                for (final destination in bottomDestinations)
                  CustomNavigationBarItem(
                    icon: destinations.indexOf(destination) == selectedIndex
                        ? Icon(
                            destination.icon,
                            size: 26,
                          )
                        : Icon(destination.icon),
                  ),
              ],
              currentIndex: selectedIndex,
              onTap: onDestinationSelected ?? (_) {},
            )
          : null,
      floatingActionButton: floatingActionButton,
    );
  }

  Scaffold _buildNavigationRailScaffold(BuildContext context) {
    const int railDestinationsOverflow = 7;
    final railDestinations = destinations.sublist(
        0, math.min(destinations.length, railDestinationsOverflow));
    final drawerDestinations = destinations.length > railDestinationsOverflow
        ? destinations.sublist(
            includeBaseDestinationsInMenu ? 0 : railDestinationsOverflow)
        : <AdaptiveDestination>[];

    return Scaffold(
      key: key,
      appBar: appBar,
      drawer: drawerDestinations.isEmpty
          ? null
          : _defaultDrawer(drawerDestinations, context),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 56,
            child: Drawer(
              backgroundColor: Theme.of(context).backgroundColor,
              elevation: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  for (final destination in railDestinations)
                    _drawerCollapsedTile(destination, context)
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(child: body),
          ),
        ],
      ),
      floatingActionButton: fabInRail ? null : floatingActionButton,
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

  Scaffold _buildNavigationDrawerScaffold() {
    return Scaffold(
      key: key,
      body: body,
      appBar: appBar,
      drawer: Drawer(
        child: Column(
          children: [
            if (drawerHeader != null) drawerHeader!,
            for (final destination in destinations)
              ListTile(
                leading: Icon(destination.icon),
                title: Text(destination.title),
                selected: destinations.indexOf(destination) == selectedIndex,
                onTap: () => _destinationTapped(destination),
              ),
          ],
        ),
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

  Widget _drawerExpandedTile(
      AdaptiveDestination destination, BuildContext context) {
    bool isSelected = destinations.indexOf(destination) == selectedIndex;
    return InkWell(
      onTap: () => _destinationTapped(destination),
      child: SizedBox(
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 16),
            isSelected
                ? Icon(
                    destination.icon,
                    size: 28,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : Opacity(
                    opacity: 0.85,
                    child: Icon(
                      destination.icon,
                      color: Theme.of(context)
                          .navigationRailTheme
                          .unselectedIconTheme
                          ?.color,
                    ),
                  ),
            // if (isSelected)
            const SizedBox(width: 20),
            isSelected
                ? Text(
                    destination.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                : Text(
                    destination.title,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.normal),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _drawerCollapsedTile(
      AdaptiveDestination destination, BuildContext context) {
    bool isSelected = destinations.indexOf(destination) == selectedIndex;
    return InkWell(
      onTap: () => _destinationTapped(destination),
      child: Container(
        width: 56,
        height: 56,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isSelected
                ? Icon(
                    destination.icon,
                    size: 28,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : Opacity(
                    opacity: 0.85,
                    child: Icon(
                      destination.icon,
                      color: Theme.of(context)
                          .navigationRailTheme
                          .unselectedIconTheme
                          ?.color,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Scaffold _buildPermanentDrawerScaffold(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        SizedBox(
          width: 230,
          child: Drawer(
            // backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
            elevation: 3,
            child: Column(
              children: [
                if (drawerHeader != null) drawerHeader!,
                const Divider(thickness: 0.7, height: 0.7),
                for (final destination in destinations)
                  _drawerExpandedTile(destination, context)
              ],
            ),
          ),
        ),
        // : SizedBox(
        //     width: 56,
        //     child: Drawer(
        //       // backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
        //       elevation: 3,
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         children: [
        //           if (drawerHeader != null) drawerHeader!,
        //           const Divider(thickness: 0.7, height: 0.7),
        //           for (final destination in destinations)
        //             _drawerCollapsedTile(destination, context)
        //         ],
        //       ),
        //     ),
        //   ),
        const VerticalDivider(
          width: 0.3,
          thickness: 0.3,
        ),
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
    ));
  }

  @override
  Scaffold build(BuildContext context) {
    final NavigationTypeResolver navigationTypeResolver =
        this.navigationTypeResolver ?? _defaultNavigationTypeResolver;
    final navigationType = navigationTypeResolver(context);

    switch (navigationType) {
      case NavigationType.bottom:
        return _buildBottomNavigationScaffold(context);
      case NavigationType.rail:
        return _buildNavigationRailScaffold(context);
      case NavigationType.drawer:
        return _buildNavigationDrawerScaffold();
      case NavigationType.permanentDrawer:
        return _buildPermanentDrawerScaffold(context);
    }
  }

  void _destinationTapped(AdaptiveDestination destination) {
    final index = destinations.indexOf(destination);
    if (index != selectedIndex) {
      onDestinationSelected?.call(index);
    }
  }
}
