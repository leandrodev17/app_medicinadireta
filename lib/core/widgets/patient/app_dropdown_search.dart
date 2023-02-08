import 'package:medicinadireta/constants/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DropdownSearch extends StatefulWidget {
  List items = [];
  List? initialValue;
  String label;
  String hint = '';
  String multiSelectTag;
  int initialIndex;
  Widget? prefixIcon;
  bool hideSearch;
  bool enabled;
  bool showClearButton;
  bool menuMode;
  bool multiSelect;
  bool? multiSelectValuesAsWidget;
  String? itemOnDialogueBox;
  String? onSelectLabel;
  List dropDownMenuItems = [];
  final ValueChanged onChanged;

  DropdownSearch({
    required this.items,
    required this.label,
    required this.onChanged,
    required this.hint,
    this.initialValue,
    required this.enabled,
    required this.showClearButton,
    this.itemOnDialogueBox,
    required this.dropDownMenuItems,
    this.prefixIcon,
    this.menuMode = false,
    this.initialIndex = 0,
    this.multiSelect = false,
    this.multiSelectTag = '',
    this.multiSelectValuesAsWidget,
    this.hideSearch = false,
    this.onSelectLabel,
  });

  @override
  _DropdownSearchState createState() => _DropdownSearchState();
}

class _DropdownSearchState extends State<DropdownSearch> {
  final searchC = TextEditingController();
  List menuData = [];
  List mainDataListGroup = [];
  List newDataList = [];
  List selectedValues = [];

  GlobalKey _key = LabeledGlobalKey("button_icon");
  late OverlayEntry _overlayEntry;
  late Size buttonSize;
  late Offset buttonPosition;
  bool isMenuOpen = true;

  void openMenu() {
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context)!.insert(_overlayEntry);
    isMenuOpen = !isMenuOpen;
  }

  void closeMenu() {
    _overlayEntry.remove();
    isMenuOpen = !isMenuOpen;
  }

  OverlayEntry _overlayEntryBuilder() {
    if (widget.dropDownMenuItems.isNotEmpty) {
      widget.onSelectLabel = widget.dropDownMenuItems[widget.initialIndex].toString();
    }
    if (widget.initialValue != null && widget.items.isNotEmpty) {
      for (int i = 0; i < widget.items.length; i++) {
        if (widget.initialValue![0]['id'] == widget.items[i][widget.initialValue![0]['param']]) {
          widget.onSelectLabel = widget.dropDownMenuItems[i].toString();
        }
      }
    }
    if (widget.items.isEmpty) {
      selectedValues.clear();
      widget.onChanged(null);
    }
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: buttonPosition.dy + buttonSize.height,
          left: buttonPosition.dx,
          width: buttonSize.width,
          child: Material(
            color: Colors.transparent,
            child: SizedBox(
              height: 300,
              child: mainScreen(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dropDownMenuItems.isNotEmpty) {
      widget.onSelectLabel = widget.dropDownMenuItems[widget.initialIndex].toString();
    }
    if (widget.items.isEmpty) {
      widget.onSelectLabel = null;
      selectedValues.clear();
      widget.onChanged(null);
      setState(() {});
    }
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      key: _key,
      child: Column(
        children: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              elevation: MaterialStateProperty.all(0),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
            ),
            child: Row(
              children: [
                widget.prefixIcon == null
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.fromLTRB(
                          0,
                          0,
                          13,
                          0,
                        ),
                        child: widget.prefixIcon),
                ((widget.multiSelect == true) && selectedValues.isNotEmpty)
                    ? Expanded(
                        child: Wrap(
                            children: List.generate(
                        selectedValues.length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                            child: Container(
                              decoration: new BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(0.0))),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                                child: Text(
                                  selectedValues[index].split('-_-')[0].toString(),
                                  style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          );
                        },
                      )))
                    : Expanded(
                        child: Text(
                        widget.label,
                        style: Theme.of(context).textTheme.subtitle2,
                      )),
                Icon(
                  Icons.expand_more_outlined,
                  color: ConstColors.grey,
                  size: 30,
                )
              ],
            ),
            onPressed: () {
              if (widget.enabled == true) {
                menuData.clear();
                if (widget.items.isNotEmpty) {
                  for (int i = 0; i < widget.dropDownMenuItems.length; i++) {
                    menuData.add(widget.dropDownMenuItems[i].toString() + '-_-' + i.toString());
                  }
                  mainDataListGroup = menuData;
                  newDataList = mainDataListGroup;
                  searchC.clear();
                  if (widget.menuMode == true) {
                    if (isMenuOpen) {
                      closeMenu();
                    } else {
                      openMenu();
                    }
                  } else {
                    showDialogueBox(context);
                  }
                }
              }
            },
          ),
          Divider(height: .5, thickness: 1, color: ConstColors.grey),
        ],
      ),
    );
  }

  Future<void> showDialogueBox(context) async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.all(15),
            child: mainScreen(),
          );
        }).then((valueFromDialog) {
      // use the value as you wish
      setState(() {});
    });
  }

  mainScreen() {
    return StatefulBuilder(builder: (context, setState) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.white, width: 1), borderRadius: BorderRadius.circular(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: TextField(
                  controller: searchC,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: ConstColors.orange,
                      ),
                      hintText: widget.hint,
                      hintStyle: Theme.of(context).textTheme.subtitle2,
                      contentPadding: EdgeInsets.only(top: 4)),
                  onChanged: (v) {
                    onItemChanged(v);
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: newDataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            elevation: MaterialStateProperty.all(0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                newDataList[index].split('-_-')[0].toString(),
                                style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                          onPressed: () {
                            if (widget.multiSelect == true) {
                              if (selectedValues.contains(newDataList[index])) {
                                setState(() {
                                  selectedValues.remove(newDataList[index]);
                                });
                              } else {
                                setState(() {
                                  selectedValues.add(newDataList[index]);
                                });
                              }
                            } else {
                              for (int i = 0; i < menuData.length; i++) {
                                if (menuData[i] == newDataList[index]) {
                                  widget.onSelectLabel = menuData[i].split('-_-')[0].toString();
                                  widget.onChanged(widget.items[i]);
                                }
                              }
                              if (widget.menuMode == true) {
                                closeMenu();
                              } else {
                                Navigator.pop(context);
                              }
                            }
                          },
                        ),
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (widget.menuMode == true) {
                        closeMenu();
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      width: 80,
                      height: 30,
                      alignment: Alignment.center,
                      child: Text('close'.tr),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  onItemChanged(String value) {
    setState(() {
      newDataList = mainDataListGroup.where((string) => string.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }
}
