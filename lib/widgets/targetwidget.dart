import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oceantodo/cubits/cubit/position_cubit.dart';
import 'package:oceantodo/models/stikersmodel.dart';
import 'package:oceantodo/widgets/dragable_widget.dart';
import 'package:oceantodo/widgets/targetdragable.dart';

Widget buildTarget(BuildContext context,
    {XFile? xFile,
    @required List<Liststicker>? stickers,
    @required DragTargetAccept<Liststicker>? onAccept,
    var drgkey,
    Offset? position}) {
  // print("landsticker;${stickers!.first.image}");
  return DragTarget<Liststicker>(
    key: drgkey,
    onLeave: (data) => true,
    onMove: (DragTargetDetails<Liststicker> data) {
      print("onmove");
    },
    builder: (context, candidateData, rejectedData) => Stack(
      fit: StackFit.loose,
      clipBehavior: Clip.none,
      // overflow: Overflow.visible,
      children: [
        IgnorePointer(
          child: xFile != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Image.file(
                    File(xFile!.path),
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                  ),
                )
              : Image.asset("assets/bg_image.jpeg", fit: BoxFit.cover),
        ),
        ...stickers!
            .map((stkrs) => BlocBuilder<PositionCubit, PositionInitial>(
                  builder: (context, state) {
                    return Positioned(
                        left: state.offset.dx,
                        top: state.offset.dy,
                        child: DraggableWidget2(
                          sticker: stkrs,
                          position: position,
                        ));
                  },
                ))
            .toList()
      ],
    ),
    onWillAccept: (data) => true,
    onAcceptWithDetails: (DragTargetDetails<Liststicker> stkers) {
      onAccept!(stkers.data);
    },
    onAccept: (data) {
      print("accept:${data.id}");
      if (stickers!.contains(data.id)) {
        print("accept:${data.image}");
      }

      // Utils.showSnackBar(
      //   context,
      //   text: 'This Is Correct 🥳',
      //   color: Colors.green,
      // );
      else {
        print("not accepted::");
        // Utils.showSnackBar(
        //   context,
        //   text: 'This Looks Wrong 🤔',
        //   color: Colors.red,
        // );
      }

      onAccept!(data);
    },
  );
}
