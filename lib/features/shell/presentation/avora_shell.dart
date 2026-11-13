import 'package:flutter/material.dart';

import '../../../features/home/presentation/home_screen.dart';
import '../../../features/library/presentation/library_screen.dart';
import '../../../features/search/presentation/search_screen.dart';

enum AvoraDestination { home, search, library }

/// Responsive application shell shared by AVORA's primary destinations.
class AvoraShell extends StatefulWidget {
  const AvoraShell({super.key, this.miniPlayer});

  /// Supplied by the playback layer when a track is active.
  /// Keeping this optional prevents an empty player from occupying the UI.
  final Widget? miniPlayer;

  @override
  State<AvoraShell> createState() => _AvoraShellState();
}

class _AvoraShellState extends State<AvoraShell> {
  AvoraDestination _destination = AvoraDestination.home;

  int get _selectedIndex => AvoraDestination.values.indexOf(_destination);

  void _selectDestination(AvoraDestination destination) {
    setState(() => _destination = destination);
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 720;
    final miniPlayer = widget.miniPlayer;
    final destinations = <NavigationDestination>[
      const NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home_rounded),
        label: 'Home',
      ),
      const NavigationDestination(
        icon: Icon(Icons.search_rounded),
        label: 'Search',
      ),
      const NavigationDestination(
        icon: Icon(Icons.library_music_outlined),
        selectedIcon: Icon(Icons.library_music_rounded),
        label: 'Library',
      ),
    ];

    const pages = <Widget>[
      HomeScreen(),
      SearchScreen(),
      LibraryScreen(),
    ];

    return PopScope(
      canPop: _destination == AvoraDestination.home,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _destination != AvoraDestination.home) {
          _selectDestination(AvoraDestination.home);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              if (isWide)
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) => _selectDestination(
                    AvoraDestination.values[index],
                  ),
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home_rounded),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.search_rounded),
                      label: Text('Search'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.library_music_outlined),
                      selectedIcon: Icon(Icons.library_music_rounded),
                      label: Text('Library'),
                    ),
                  ],
                ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: IndexedStack(
                        index: _selectedIndex,
                        children: pages,
                      ),
                    ),
                    if (miniPlayer != null) miniPlayer,
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: isWide
            ? null
            : NavigationBar(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (index) => _selectDestination(
                  AvoraDestination.values[index],
                ),
                destinations: destinations,
              ),
      ),
    );
  }
}
