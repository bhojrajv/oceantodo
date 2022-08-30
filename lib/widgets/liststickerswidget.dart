import 'package:flutter/cupertino.dart';
import 'package:oceantodo/models/stikersmodel.dart';

import 'dragable_widget.dart';

Widget Liststickerwidg({
  Liststicker? stickers,
  @required DragTargetAccept<Liststicker>? onAccept,
}) {
  return DragTarget<Liststicker>(
      builder: (context, candidateData, rejectedData) =>
          DraggableWidget(sticker: stickers),
      onWillAccept: (data) => true,
      onAccept: (data) {
        // if (acceptTypes.contains(data.type)) {
        //   Utils.showSnackBar(
        //     context,
        //     text: 'This Is Correct 🥳',
        //     color: Colors.green,
        //   );
        // } else {
        //   Utils.showSnackBar(
        //     context,
        //     text: 'This Looks Wrong 🤔',
        //     color: Colors.red,
        //   );
        onAccept!(data);
      });
}
