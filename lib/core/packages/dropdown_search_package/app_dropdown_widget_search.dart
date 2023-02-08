
import 'package:flutter/material.dart';

import 'searchable_dropdown/lib/dropdown_search.dart';
import 'searchable_dropdown/lib/src/properties/properties.dart';

/// FONTE: https://pub.dev/packages/dropdown_search

class AppDropdownWidgetSearch<T> extends StatefulWidget {
  ///show/hide the search box
  final bool showSearchBox;

  ///true if the filter on items is applied onlie (via API)
  final bool isFilteredOnline;

  ///show/hide clear selected item
  final bool showClearButton;

  ///offline items list
  final List<T>? items;

  ///selected item
  final T? selectedItem;

  ///selected items
  final List<T> selectedItems;

  ///function that returns item from API
  final DropdownSearchOnFind<T>? onFind;

  ///called when a new item is selected
  final ValueChanged<T?>? onChanged;

  ///called when a new items are selected
  final ValueChanged<List<T>>? onChangedMultiSelection;

  ///to customize list of items UI
  final DropdownSearchBuilder<T>? dropdownBuilder;

  ///to customize list of items UI in MultiSelection mode
  final DropdownSearchBuilderMultiSelection<T>? dropdownBuilderMultiSelection;

  ///to customize selected item
  final DropdownSearchPopupItemBuilder<T>? popupItemBuilder;

  ///the title for dialog/menu/bottomSheet
  final Color? popupBackgroundColor;

  ///custom widget for the popup title
  final Widget? popupTitle;

  ///customize the fields the be shown
  final DropdownSearchItemAsString<T>? itemAsString;

  ///	custom filter function
  final DropdownSearchFilterFn<T>? filterFn;

  ///enable/disable dropdownSearch
  final bool enabled;

  ///MENU / DIALOG/ BOTTOM_SHEET
  final Mode mode;

  ///the max height for dialog/bottomSheet/Menu
  final double? maxHeight;

  ///the max width for the dialog
  final double? dialogMaxWidth;

  ///select the selected item in the menu/dialog/bottomSheet of items
  final bool showSelectedItems;

  ///function that compares two T with the same type to detected if it's the selected item or not
  final DropdownSearchCompareFn<T>? compareFn;

  ///dropdownSearch input decoration
  final InputDecoration? dropdownSearchDecoration;

  /// style on which to base the label
  final TextStyle? dropdownSearchBaseStyle;

  /// How the text in the decoration should be aligned horizontally.
  final TextAlign? dropdownSearchTextAlign;

  /// How the text should be aligned vertically.
  final TextAlignVertical? dropdownSearchTextAlignVertical;

  ///custom layout for empty results
  final EmptyBuilder? emptyBuilder;

  ///custom layout for loading items
  final LoadingBuilder? loadingBuilder;

  ///custom layout for error
  final ErrorBuilder? errorBuilder;

  ///custom shape for the popup
  final ShapeBorder? popupShape;

  final AutovalidateMode? autoValidateMode;

  /// An optional method to call with the final value when the form is saved via
  final FormFieldSetter<T>? onSaved;

  /// An optional method to call with the final value when the form is saved via
  final FormFieldSetter<List<T>>? onSavedMultiSelection;

  /// An optional method that validates an input. Returns an error string to
  /// display if the input is invalid, or null otherwise.
  final FormFieldValidator<T>? validator;
  final FormFieldValidator<List<T>>? validatorMultiSelection;

  ///custom dropdown clear button icon widget
  final Widget? clearButton;

  ///custom clear button widget builder
  final IconButtonBuilder? clearButtonBuilder;

  ///custom splash radius for the clear button
  ///If null, default splash radius of [icon_button] is used.
  final double? clearButtonSplashRadius;

  ///custom dropdown icon button widget
  final Widget? dropDownButton;

  ///custom dropdown button widget builder
  final IconButtonBuilder? dropdownButtonBuilder;

  ///custom splash radius for the dropdown button
  ///If null, default splash radius of [icon_button] is used.
  final double? dropdownButtonSplashRadius;

  ///whether to manage the clear and dropdown icons via InputDecoration suffixIcon
  final bool showAsSuffixIcons;

  ///If true, the dropdownBuilder will continue the uses of material behavior
  ///This will be useful if you want to handle a custom UI only if the item !=null
  final bool dropdownBuilderSupportsNullItem;

  ///defines if an item of the popup is enabled or not, if the item is disabled,
  ///it cannot be clicked
  final DropdownSearchPopupItemEnabled<T>? popupItemDisabled;

  ///set a custom color for the popup barrier
  final Color? popupBarrierColor;

  ///called when popup is dismissed
  final VoidCallback? onPopupDismissed;

  /// callback executed before applying value change
  ///delay before searching, change it to Duration(milliseconds: 0)
  ///if you do not use online search
  final Duration? searchDelay;

  /// callback executed before applying value change
  final BeforeChange<T>? onBeforeChange;

  /// callback executed before applying values changes
  final BeforeChangeMultiSelection<T>? onBeforeChangeMultiSelection;

  ///show or hide favorites items
  final bool showFavoriteItems;

  ///to customize favorites chips
  final FavoriteItemsBuilder<T>? favoriteItemBuilder;

  ///favorites items list
  final FavoriteItems<T>? favoriteItems;

  ///favorite items alignment
  final MainAxisAlignment? favoriteItemsAlignment;

  ///set properties of popup safe area
  final PopupSafeAreaProps popupSafeArea;

  /// T that passes all props to search field
  final TextFieldProps? searchFieldProps;

  /// scrollbar properties
  final ScrollbarProps? scrollbarProps;

  /// whether modal can be dismissed by tapping the modal barrier
  final bool popupBarrierDismissible;

  ///define whatever we are in multi selection mode or single selection mode
  final bool isMultiSelectionMode;

  ///called when a new item added on Multi selection mode
  final OnItemAdded<T>? popupOnItemAdded;

  ///called when a new item added on Multi selection mode
  final OnItemRemoved<T>? popupOnItemRemoved;

  ///widget used to show checked items in multiSelection mode
  final DropdownSearchPopupItemBuilder<T>? popupSelectionWidget;

  ///widget used to validate items in multiSelection mode
  final ValidationMultiSelectionBuilder<T?>? popupValidationMultiSelectionWidget;

  /// elevation for popup items
  final double popupElevation;

  /// props for selection list view
  final SelectionListViewProps selectionListViewProps;

  /// props for selection focus node
  final FocusNode? focusNode;

  /// function to override position calculation
  final PositionCallback? positionCallback;

  final Color? fillColor;

  AppDropdownWidgetSearch({
    Key? key,
    this.onSaved,
    this.validator,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.onChanged,
    this.mode = Mode.DIALOG,
    this.isFilteredOnline = false,
    this.popupTitle,
    this.items,
    this.selectedItem,
    this.onFind,
    this.dropdownBuilder,
    this.popupItemBuilder,
    this.showSearchBox = false,
    this.showClearButton = false,
    this.popupBackgroundColor,
    this.enabled = true,
    this.maxHeight,
    this.filterFn,
    this.itemAsString,
    this.showSelectedItems = false,
    this.compareFn,
    this.dropdownSearchDecoration,
    this.emptyBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.dialogMaxWidth,
    this.clearButton,
    this.clearButtonBuilder,
    this.clearButtonSplashRadius,
    this.dropDownButton,
    this.dropdownButtonBuilder,
    this.dropdownButtonSplashRadius,
    this.showAsSuffixIcons = false,
    this.dropdownBuilderSupportsNullItem = false,
    this.popupShape,
    this.popupItemDisabled,
    this.popupBarrierColor,
    this.onPopupDismissed,
    this.searchDelay,
    this.onBeforeChange,
    this.favoriteItemBuilder,
    this.favoriteItems,
    this.showFavoriteItems = false,
    this.favoriteItemsAlignment = MainAxisAlignment.start,
    this.popupSafeArea = const PopupSafeAreaProps(),
    TextFieldProps? searchFieldProps,
    this.scrollbarProps,
    this.popupBarrierDismissible = true,
    this.dropdownSearchBaseStyle,
    this.dropdownSearchTextAlign,
    this.dropdownSearchTextAlignVertical,
    this.popupElevation = 8,
    this.selectionListViewProps = const SelectionListViewProps(),
    this.focusNode,
    this.positionCallback,
    this.fillColor = Colors.white,
  })  : assert(!showSelectedItems || T == String || compareFn != null),
        this.searchFieldProps = searchFieldProps ?? TextFieldProps(),
        this.isMultiSelectionMode = false,
        this.dropdownBuilderMultiSelection = null,
        this.validatorMultiSelection = null,
        this.onBeforeChangeMultiSelection = null,
        this.selectedItems = const [],
        this.onSavedMultiSelection = null,
        this.onChangedMultiSelection = null,
        this.popupOnItemAdded = null,
        this.popupOnItemRemoved = null,
        this.popupSelectionWidget = null,
        this.popupValidationMultiSelectionWidget = null,
        super(key: key);

  @override
  _AppDropdownWidgetSearchState createState() => _AppDropdownWidgetSearchState();
}

class _AppDropdownWidgetSearchState extends State<AppDropdownWidgetSearch> {
  @override
  Widget build(BuildContext context) {
    return DropdownSearch(
      key: widget.key,
      autoValidateMode: widget.autoValidateMode,
      clearButton: widget.clearButton,
      clearButtonBuilder: widget.clearButtonBuilder,
      clearButtonSplashRadius: widget.clearButtonSplashRadius,
      compareFn: widget.compareFn,
      dialogMaxWidth: widget.dialogMaxWidth,
      dropDownButton: widget.dropDownButton,
      dropdownBuilder: widget.dropdownBuilder,
      dropdownBuilderSupportsNullItem: widget.dropdownBuilderSupportsNullItem,
      dropdownButtonBuilder: widget.dropdownButtonBuilder,
      dropdownButtonSplashRadius: widget.dropdownButtonSplashRadius,
      dropdownSearchBaseStyle: widget.dropdownSearchBaseStyle,
      dropdownSearchDecoration: widget.dropdownSearchDecoration,
      dropdownSearchTextAlign: widget.dropdownSearchTextAlign,
      dropdownSearchTextAlignVertical: widget.dropdownSearchTextAlignVertical,
      emptyBuilder: widget.emptyBuilder,
      enabled: widget.enabled,
      errorBuilder: widget.errorBuilder,
      favoriteItemBuilder: widget.favoriteItemBuilder,
      favoriteItems: widget.favoriteItems,
      favoriteItemsAlignment: widget.favoriteItemsAlignment,
      filterFn: widget.filterFn,
      focusNode: widget.focusNode,
      isFilteredOnline: widget.isFilteredOnline,
      itemAsString: widget.itemAsString,
      items: widget.items,
      loadingBuilder: widget.loadingBuilder,
      maxHeight: widget.maxHeight,
      mode: widget.mode,
      onBeforeChange: widget.onBeforeChange,
      onChanged: widget.onChanged,
      onFind: widget.onFind,
      onPopupDismissed: widget.onPopupDismissed,
      onSaved: widget.onSaved,
      popupBackgroundColor: widget.popupBackgroundColor,
      popupBarrierColor: widget.popupBarrierColor,
      popupBarrierDismissible: widget.popupBarrierDismissible,
      popupElevation: widget.popupElevation,
      popupItemBuilder: widget.popupItemBuilder,
      popupItemDisabled: widget.popupItemDisabled,
      popupSafeArea: widget.popupSafeArea,
      popupShape: widget.popupShape,
      popupTitle: widget.popupTitle,
      positionCallback: widget.positionCallback,
      scrollbarProps: widget.scrollbarProps,
      searchDelay: widget.searchDelay,
      searchFieldProps: widget.searchFieldProps,
      selectedItem: widget.selectedItem,
      selectionListViewProps: widget.selectionListViewProps,
      showAsSuffixIcons: widget.showAsSuffixIcons,
      showClearButton: widget.showClearButton,
      showFavoriteItems: widget.showFavoriteItems,
      showSearchBox: widget.showSearchBox,
      showSelectedItems: widget.showSelectedItems,
      validator: widget.validator,
      fillColor: widget.fillColor,
    );
  }
}
