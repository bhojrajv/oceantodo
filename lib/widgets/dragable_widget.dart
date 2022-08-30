import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oceantodo/cubits/cubit/actions/actions_cubit.dart';
import 'package:oceantodo/cubits/cubit/position_cubit.dart';
import 'package:oceantodo/models/stikersmodel.dart';

class DraggableWidget extends StatefulWidget {
  final Liststicker? sticker;
  final String? typeimg;
  Offset? position = Offset(0, 0);
  DraggableWidget(
      {Key? key, @required this.sticker, this.typeimg, this.position})
      : super(key: key);

  @override
  State<DraggableWidget> createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  static double size = 50;
  static Offset position = Offset(100, 100);
  @override
  Widget build(BuildContext context) {
    print("landst2:${widget.sticker!.image}");
    return Draggable<Liststicker>(
      //feedbackOffset: context.read<PositionCubit>().state.offset,
      data: widget.sticker,
      onDragStarted: () {
        context.read<ActionsCubit>().delete("", 0);
      },
      onDragUpdate: (updpostion) {
        //  print("postion:${updpostion.delta.dx}");
        // context.read<PositionCubit>().udatepostion(updpostion.delta);
      },
      onDragEnd: (details) {
        context.read<PositionCubit>().udatepostion(details.offset);
        print("dragend:${details.offset.dx}");
      },
      feedback: buildImage(context),
      child: buildImage(context),
      childWhenDragging: Container(height: size),
    );
  }

  Widget buildImage(context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
        ),
        child: Image.network(
          widget.sticker!.image!,
          fit: BoxFit.cover,
          height: size,
          width: size,
        ),
      );
}
