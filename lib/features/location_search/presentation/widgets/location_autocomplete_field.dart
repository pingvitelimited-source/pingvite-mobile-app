import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/location_search/domain/entities/location_suggestion.dart';
import 'package:pingvite/features/location_search/presentation/bloc/location_search_bloc.dart';
import 'package:pingvite/features/location_search/presentation/bloc/location_search_event.dart';
import 'package:pingvite/features/location_search/presentation/bloc/location_search_state.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class LocationAutocompleteField extends StatefulWidget {
  final String name;
  final String hintText;
  final String locationType; // 'country', 'state', 'city'
  final String? parentId; // countryId for states, stateId for cities
  final Function(LocationSuggestion?) onSelected;
  final String? errorText;
  final bool enabled;

  const LocationAutocompleteField({
    super.key,
    required this.name,
    required this.hintText,
    required this.locationType,
    required this.onSelected,
    this.parentId,
    this.errorText,
    this.enabled = true,
  });

  @override
  State<LocationAutocompleteField> createState() =>
      _LocationAutocompleteFieldState();
}

class _LocationAutocompleteFieldState extends State<LocationAutocompleteField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      _searchLocations(_controller.text);
    } else {
      _removeOverlay();
    }
  }

  void _searchLocations(String query) {
    if (!widget.enabled) return;

    final bloc = context.read<LocationSearchBloc>();

    switch (widget.locationType) {
      case 'country':
        bloc.add(SearchCountriesEvent(query));
        break;
      case 'state':
        if (widget.parentId != null) {
          bloc.add(
            SearchStatesEvent(query: query, countryId: widget.parentId!),
          );
        }
        break;
      case 'city':
        if (widget.parentId != null) {
          bloc.add(SearchCitiesEvent(query: query, stateId: widget.parentId!));
        }
        break;
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay(List<LocationSuggestion> suggestions) {
    _removeOverlay();

    if (suggestions.isEmpty || !_focusNode.hasFocus) {
      // Clear loading state when no suggestions or not focused
      setState(() {
        _isLoading = false;
      });
      return;
    }

    _overlayEntry = _createOverlayEntry(suggestions);
    Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry(List<LocationSuggestion> suggestions) {
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(sl<SizeConfig>().rpx(8)),
            child: Container(
              constraints: BoxConstraints(maxHeight: sl<SizeConfig>().rpx(200)),
              decoration: BoxDecoration(
                color: buttonTheme.fillColor,
                borderRadius: BorderRadius.circular(sl<SizeConfig>().rpx(8)),
                border: Border.all(color: buttonTheme.borderColor, width: 1),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = suggestions[index];
                  return InkWell(
                    onTap: () {
                      _controller.text = suggestion.name;
                      widget.onSelected(suggestion);
                      _removeOverlay();
                      _focusNode.unfocus();
                      // Clear loading state when selection is made
                      setState(() {
                        _isLoading = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: sl<SizeConfig>().rpx(16),
                        vertical: sl<SizeConfig>().rpx(12),
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: buttonTheme.borderColor.withValues(
                              alpha: 0.3,
                            ),
                            width: index < suggestions.length - 1 ? 1 : 0,
                          ),
                        ),
                      ),
                      child: Text(suggestion.name, style: textTheme.body),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return BlocListener<LocationSearchBloc, LocationSearchState>(
      listener: (context, state) {
        if (state is CountriesLoaded && widget.locationType == 'country') {
          setState(() {
            _isLoading = false;
          });
          _showOverlay(state.countries);
        } else if (state is StatesLoaded && widget.locationType == 'state') {
          setState(() {
            _isLoading = false;
          });
          _showOverlay(state.states);
        } else if (state is CitiesLoaded && widget.locationType == 'city') {
          setState(() {
            _isLoading = false;
          });
          _showOverlay(state.cities);
        } else if (state is LocationSearchLoading) {
          // Only show loading if this field is currently focused
          if (_focusNode.hasFocus) {
            setState(() {
              _isLoading = true;
            });
          }
        } else if (state is LocationSearchFailure) {
          if (_focusNode.hasFocus) {
            setState(() {
              _isLoading = false;
            });
          }
          _removeOverlay();
        }
      },
      child: CompositedTransformTarget(
        link: _layerLink,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: sl<SizeConfig>().rpx(16),
                vertical: sl<SizeConfig>().rpx(4),
              ),
              decoration: BoxDecoration(
                color: buttonTheme.fillColor,
                borderRadius: BorderRadius.circular(sl<SizeConfig>().rpx(8)),
                border: Border.all(
                  color: widget.errorText != null
                      ? Colors.red
                      : buttonTheme.borderColor,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      enabled: widget.enabled,
                      style: textTheme.body,
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        hintStyle: textTheme.body,
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      onChanged: (value) {
                        _searchLocations(value);
                      },
                    ),
                  ),
                  if (_isLoading)
                    SizedBox(
                      width: sl<SizeConfig>().rpx(16),
                      height: sl<SizeConfig>().rpx(16),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.blue,
                      ),
                    ),
                ],
              ),
            ),
            if (widget.errorText != null)
              Padding(
                padding: EdgeInsets.only(
                  top: sl<SizeConfig>().rpx(4),
                  left: sl<SizeConfig>().rpx(16),
                ),
                child: Text(
                  widget.errorText!,
                  style: textTheme.body2.copyWith(
                    fontSize: sl<SizeConfig>().rpx(12),
                    color: Colors.red,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
