import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FancyExpansionTile(
        titleContent: const Text('عرض المزيد',),
          child:Column(
            children: const [
              Text('child'),
              Text('child'),
              Text('child'),
            ],
          )
      )
    );
  }
}

class FancyExpansionTile extends StatefulWidget {
  const FancyExpansionTile({Key? key, this.upButtonColor,
    this.downButtonColor,
    this.padding, this.dividerColor, this.upButtonIcon,
    this.downButtonIcon, this.buttonElevation,
    this.buttonBackgroundColorOnOpen,
    this.buttonBackgroundColorOnClose,
    this.isDisable,
    required this.titleContent, required this.child,
    this.childAlignment, this.titleTextDirection}) : super(key: key);

  final Widget titleContent;
  final Widget child;
  final Color? upButtonColor;
  final IconData? upButtonIcon;
  final Color? downButtonColor;
  final IconData? downButtonIcon;
  final Color? buttonBackgroundColorOnOpen;
  final Color? buttonBackgroundColorOnClose;
  final Color? dividerColor;
  final EdgeInsetsGeometry? padding;
  final double? buttonElevation;
  final bool? isDisable;
  final CrossAxisAlignment? childAlignment;
  final TextDirection? titleTextDirection;

  @override
  State<FancyExpansionTile> createState() => _FancyExpansionTileState();
}

class _FancyExpansionTileState extends State<FancyExpansionTile> {
  bool isOpen = false;
  BorderSide border =const BorderSide(color: Colors.blue);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      child: Directionality(
        textDirection: widget.titleTextDirection ?? TextDirection.ltr,
        child: Column(
          crossAxisAlignment: widget.childAlignment ?? CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    elevation: widget.buttonElevation,
                    color: isOpen ?  widget.buttonBackgroundColorOnOpen ?? Colors.blue :
                    widget.buttonBackgroundColorOnClose ?? Colors.white,
                    child: AbsorbPointer(
                      absorbing: widget.isDisable ?? false,
                      child: InkWell(
                        child: Icon(isOpen ? widget.upButtonIcon ?? Icons.arrow_drop_up :
                            widget.downButtonIcon ?? Icons.arrow_drop_down,
                            color: isOpen ? Colors.white : Colors.black
                        ),
                        onTap: (){
                          setState(() {
                            isOpen = !isOpen;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 5,),
                  widget.titleContent
                ],
              ),
            ),
            Divider(color: widget.dividerColor),
            if (isOpen) widget.child else const SizedBox(),
          ],
        ),
      ),
    );
  }
}

