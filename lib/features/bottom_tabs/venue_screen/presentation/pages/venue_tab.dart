import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/custom_fab.dart';
import 'package:pingvite/core/routes.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/features/bottom_tabs/venue_screen/data/model/venue.dart';
import 'package:pingvite/features/bottom_tabs/venue_screen/presentation/widgets/venue_card.dart';
import 'package:pingvite/features/bottom_tabs/venue_screen/presentation/widgets/venue_options_dialog.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/custom_appbar.dart';

class VenueTab extends StatefulWidget {
  const VenueTab({super.key});

  @override
  State<VenueTab> createState() => _VenueTabState();
}

class _VenueTabState extends State<VenueTab> {
  int _selectedIndex = 0;

  final List<String> _tabs = ['All Venues', 'Drafts'];

  final List<Venue> _allVenues = [
    Venue(
      name: "MCC Banquet Hall",
      location: "Mumbai",
      address: "BKC Junction, Mumbai",
      capacity: "1000",
      image: Constants.venueImage,
    ),
    Venue(
      name: "Palava Cricket Ground",
      location: "Palava",
      address: "Lodha Palava, Dombivili",
      capacity: "5000",
      image: Constants.venueImage,
    ),
  ];

  final List<Venue> _draftVenues = [
    Venue(
      name: "Draft Venue",
      location: "Delhi",
      address: "Connaught Place, Delhi",
      capacity: "500",
      image: Constants.venueImage,
      isDraft: true,
    ),
  ];

  Future<void> _showVenueOptions(BuildContext context) async {
    final navigator = Navigator.of(context);
    final action = await VenueOptionsDialog.show(context);
    if (action == null || !mounted) return;

    switch (action) {
      case VenueAction.addNewVenue:
        navigator.pushNamed(AppRoutes.createVenue);
        break;
    }
  }

  void _handleVenueAction(Venue venue, VenueCardAction action) {
    switch (action) {
      case VenueCardAction.edit:
        // Handle edit
        debugPrint('Edit venue: ${venue.name}');
        break;
      case VenueCardAction.duplicate:
        // Handle duplicate
        debugPrint('Duplicate venue: ${venue.name}');
        break;
      case VenueCardAction.delete:
        // Handle delete
        debugPrint('Delete venue: ${venue.name}');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Scaffold(
      backgroundColor: AppColors.homebackground,
      appBar: const CustomAppBar.withBackButton(title: 'My Venues'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Full width tabs
          Container(
            margin: EdgeInsets.symmetric(vertical: 2.rpx),
            padding: EdgeInsets.all(4.rpx),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.rpx),
            ),
            child: Row(
              children: List.generate(_tabs.length, (index) {
                final isSelected = _selectedIndex == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(vertical: 10.rpx),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.blue : AppColors.white,
                        borderRadius: BorderRadius.circular(6.rpx),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppColors.black.withValues(alpha: 0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                ),
                              ]
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          _tabs[index],
                          style: textTheme.body2.copyWith(
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: isSelected
                                ? AppColors.white
                                : AppColors.grey.withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(child: _buildTabContent()),
        ],
      ),
      floatingActionButton: CustomFAB(
        onPressed: () => _showVenueOptions(context),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildVenueList(_allVenues);
      case 1:
        return _buildVenueList(_draftVenues);
      default:
        return _buildVenueList(_allVenues);
    }
  }

  Widget _buildVenueList(List<Venue> venues) {
    if (venues.isEmpty) {
      return const Center(child: Text('No venues found'));
    }
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.rpx, vertical: 16.rpx),
      itemCount: venues.length,
      itemBuilder: (context, index) => VenueCard(
        venue: venues[index],
        onAction: (action) => _handleVenueAction(venues[index], action),
      ),
    );
  }
}
