import 'package:flutter/material.dart';

class FloatingBottomNavList extends StatelessWidget {
  const FloatingBottomNavList({
    Key? key,
    required this.selectedIndex,
    this.curve = Curves.easeOutQuint,
    this.duration = const Duration(milliseconds: 750),
    this.height,
    this.backgroundColor,
    this.itemPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    required this.items,
    required this.onTap,
    this.textStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    required this.activeColor,
    this.disabledColor = Colors.grey,
    this.backgroundRadius = 20,
  }) : super(key: key);
  final int selectedIndex;
  final Curve curve;
  final Duration duration;
  final num? height;
  final Color? backgroundColor;
  final EdgeInsets itemPadding;
  final List<FloatingBottomNavListItem> items;
  final ValueChanged<int> onTap;
  final TextStyle textStyle;
  final Color activeColor;
  final Color disabledColor;
  final double backgroundRadius;
  @override
  Widget build(BuildContext context) {
    // final _brightness = Theme.of(context).brightness;
    return Container(
      height: height?.toDouble(),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(backgroundRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                items.length,
                (int index) {
                  final _selectedColor = activeColor;
                  final _selectedColorWithOpacity =
                      activeColor.withOpacity(0.1);

                  final _inactiveColor = disabledColor;

                  final _rightPadding = itemPadding.right;

                  return _FloatingBottonNavListItemWidget(
                    index: index,
                    key: items.elementAt(index).key,
                    isSelected: index == selectedIndex,
                    selectedColor: _selectedColor,
                    selectedColorWithOpacity: _selectedColorWithOpacity,
                    inactiveColor: _inactiveColor,
                    rightPadding: _rightPadding,
                    curve: curve,
                    duration: duration,
                    itemPadding: itemPadding,
                    textStyle: textStyle,
                    icon: items.elementAt(index).icon,
                    title: items.elementAt(index).title,
                    onTap: () => onTap(index),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
    // return Container(
    //   height: height?.toDouble(),
    //   decoration: BoxDecoration(
    //       // boxShadow: [],
    //       color: backgroundColor,
    //       borderRadius: BorderRadius.circular(backgroundRadius)),
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    //     child: SingleChildScrollView(
    //       scrollDirection: Axis.horizontal,
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: List.generate(
    //           items.length,
    //           (int index) {
    // final _selectedColor = activeColor;
    // final _selectedColorWithOpacity = activeColor.withOpacity(0.1);

    // final _inactiveColor = disabledColor;

    // final _rightPadding = itemPadding.right;
    //             return _FloatingBottonNavListItemWidget(
    //               index: index,
    //               key: items.elementAt(index).key,
    //               isSelected: index == selectedIndex,
    //               selectedColor: _selectedColor,
    //               selectedColorWithOpacity: _selectedColorWithOpacity,
    //               inactiveColor: _inactiveColor,
    //               rightPadding: _rightPadding,
    //               curve: curve,
    //               duration: duration,
    //               itemPadding: itemPadding,
    //               textStyle: textStyle,
    //               icon: items.elementAt(index).icon,
    //               title: items.elementAt(index).title,
    //               onTap: () => onTap(index),
    //             );
    //           },
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

class _FloatingBottonNavListItemWidget extends StatelessWidget {
  const _FloatingBottonNavListItemWidget(
      {Key? key,
      required this.index,
      required this.isSelected,
      required this.selectedColor,
      required this.selectedColorWithOpacity,
      required this.inactiveColor,
      required this.rightPadding,
      required this.curve,
      required this.duration,
      required this.itemPadding,
      required this.textStyle,
      required this.icon,
      required this.title,
      required this.onTap})
      : super(key: key);

  final int index;

  final bool isSelected;

  final Color selectedColor;

  final Color selectedColorWithOpacity;
  final Color inactiveColor;
  final double rightPadding;
  final Curve curve;
  final Duration duration;
  final EdgeInsets itemPadding;
  final TextStyle textStyle;
  final Widget icon;
  final Widget title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(
        begin: 0,
        end: isSelected ? 1 : 0,
      ),
      curve: curve,
      duration: duration,
      builder: (BuildContext context, double value, Widget? child) {
        return Material(
          shape: const StadiumBorder(),
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            customBorder: const StadiumBorder(),
            focusColor: selectedColorWithOpacity,
            highlightColor: selectedColorWithOpacity,
            splashColor: selectedColorWithOpacity,
            hoverColor: selectedColorWithOpacity,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isSelected ? selectedColor : null,
              ),
              child: Padding(
                padding:
                    itemPadding - EdgeInsets.only(right: rightPadding * value),
                child: Row(
                  children: [
                    IconTheme(
                      data: IconThemeData(
                        color: Color.lerp(inactiveColor, Colors.white, value),
                        size: 24,
                      ),
                      child: icon,
                    ),
                    ClipRect(
                      child: SizedBox(
                        height: 20,
                        child: Align(
                          alignment: const Alignment(-0.2, 0),
                          widthFactor: value,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: rightPadding / 2,
                              right: rightPadding,
                            ),
                            child: DefaultTextStyle(
                              style: textStyle.copyWith(
                                color: Color.lerp(
                                    Colors.transparent, Colors.white, value),
                              ),
                              child: isSelected ? title : Container(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class FloatingBottomNavListItem {
  FloatingBottomNavListItem({
    this.key,
    required this.icon,
    required this.title,
    required this.id,
  });
  final int id;
  final Key? key;
  final Widget icon;
  final Widget title;
}
