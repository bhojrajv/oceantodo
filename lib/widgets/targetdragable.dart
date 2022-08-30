import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oceantodo/cubits/cubit/actions/actions_cubit.dart';
import 'package:oceantodo/cubits/cubit/position_cubit.dart';
import 'package:oceantodo/models/stikersmodel.dart';

class DraggableWidget2 extends StatefulWidget {
  final Liststicker? sticker;
  final String? typeimg;
  Offset? position = Offset(0, 0);
  DraggableWidget2(
      {Key? key, @required this.sticker, this.typeimg, this.position})
      : super(key: key);

  @override
  State<DraggableWidget2> createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget2> {
  static double size = 30;
  static Offset position = Offset(100, 100);
  @override
  Widget build(BuildContext context) {
    print("landst2:${widget.sticker!.image}");
    return BlocBuilder<ActionsCubit, ActionsInitial>(
      builder: (context, state) {
        return context.watch<ActionsCubit>().state.type == "delete"
            ? SizedBox()
            : Draggable<Liststicker>(
                //feedbackOffset: context.read<PositionCubit>().state.offset,
                data: widget.sticker,
                onDragUpdate: (updpostion) {
                  //  print("postion:${updpostion.delta.dx}");
                  // context.read<PositionCubit>().udatepostion(updpostion.delta);
                },
                onDragEnd: (details) {
                  context.read<PositionCubit>().udatepostion(details.offset);
                  print("dragend:${details.offset.dx}");
                },
                feedback: buildImage(context, state),
                child: buildImage(context, state),
                childWhenDragging: Container(height: size),
              );
      },
    );
  }

  Widget buildImage(context, state) => Stack(
        fit: StackFit.loose,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: BlocProvider.of<ActionsCubit>(context).state.type == "scale"
                ? double.parse(BlocProvider.of<ActionsCubit>(context)
                            .state
                            .incr
                            .toString()) <=
                        125.0
                    ? 125.0
                    : double.parse(BlocProvider.of<ActionsCubit>(context)
                        .state
                        .incr
                        .toString())
                : 125.0,
            width: BlocProvider.of<ActionsCubit>(context).state.type == "scale"
                ? double.parse(BlocProvider.of<ActionsCubit>(context)
                            .state
                            .incr
                            .toString()) <=
                        120.0
                    ? 120.0
                    : double.parse(BlocProvider.of<ActionsCubit>(context)
                        .state
                        .incr
                        .toString())
                : 120.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(2),
              color: Colors.white,
            ),
            child: imagewidge(""),
          ),
          Positioned(
              right: 108,
              bottom: 112,
              child: GestureDetector(
                onTap: () {
                  print("delet::");
                  BlocProvider.of<ActionsCubit>(context, listen: false)
                      .delete("delete", 0);
                },
                child: Icon(
                  Icons.delete,
                  size: 20,
                  color: Colors.black,
                ),
              )),
          Positioned(
              left: 108,
              bottom: 112,
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<ActionsCubit>(context, listen: false)
                      .doActions2("rotate", 40);
                  print("rotatesum:${state.incr}");
                },
                child: Icon(
                  Icons.rotate_90_degrees_cw,
                  size: 20,
                  color: Colors.black,
                ),
              )),
          Positioned(
              right: 108,
              top: 112,
              child: GestureDetector(
                onTap: () {
                  print("flip::");
                  BlocProvider.of<ActionsCubit>(context, listen: false)
                      .flips("flip", 180);
                },
                child: Icon(
                  Icons.flip,
                  size: 20,
                  color: Colors.black,
                ),
              )),
          Positioned(
              left: 108,
              top: 112,
              child: GestureDetector(
                onTap: () {
                  print("scalled:");
                  BlocProvider.of<ActionsCubit>(context, listen: false)
                      .scalled("scale", 40);
                },
                child: Icon(
                  Icons.scale,
                  size: 20,
                  color: Colors.black,
                ),
              )),
        ],
      );

  Widget imagewidge(String type) {
    if (context.watch<ActionsCubit>().state.type == "rotate") {
      return RotationTransition(
        turns: AlwaysStoppedAnimation(
            context.watch<ActionsCubit>().state.incr! / 360),
        child: Image.network(
          widget.sticker!.image!,
          fit: BoxFit.cover,
          height: size,
          width: size,
        ),
      );
    }
    if (context.watch<ActionsCubit>().state.type == "flip") {
      return Transform(
        alignment: Alignment.center,
        transform:
            Matrix4.rotationY(context.watch<ActionsCubit>().state.incr / 360),
        child: Image.network(
          widget.sticker!.image!,
          fit: BoxFit.cover,
          height: size,
          width: size,
        ),
      );
    }
    if (context.watch<ActionsCubit>().state.type == "scale") {
      return Image.network(
        widget.sticker!.image!,
        fit: BoxFit.cover,
        height: context.watch<ActionsCubit>().state.incr <= size
            ? size
            : double.parse(context.watch<ActionsCubit>().state.incr.toString()),
        width: context.watch<ActionsCubit>().state.incr <= 0
            ? size
            : double.parse(context.watch<ActionsCubit>().state.incr.toString()),
      );
    }
    if (context.watch<ActionsCubit>().state.type == "delete") {
      return SizedBox();
    }
    return Image.network(
      widget.sticker!.image!,
      fit: BoxFit.contain,
      height: size,
      width: size,
    );
  }
}
