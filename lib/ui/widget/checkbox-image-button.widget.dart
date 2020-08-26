import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

@immutable
class CheckboxImageButton extends StatelessWidget {
  final bool enabled;
  final String image;
  final Function onPressed;
  final String text;

  CheckboxImageButton({
    @required this.enabled,
    @required this.image,
    Key key,
    @required this.onPressed,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: MaterialButton(
        child: _getButtonChild(context),
        color: enabled ? Theme.of(context).primaryColor : Colors.white,
        elevation: 0,
        key: key,
        onPressed: onPressed,
        padding: EdgeInsets.all(5),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1)),
      ),
    );
  }

  Container _getButtonChild(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 150),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(image),
                radius: 24,
              ),
            ),
            Expanded(
              child: Text(text, style: TextStyle(color: enabled ? Colors.white : Colors.black)),
            )
          ],
        ),
      ),
    );
  }
}
