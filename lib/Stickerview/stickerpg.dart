import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oceantodo/Blocs/bloc/stickers_bloc.dart';
import 'package:oceantodo/cubits/cubit/actions/actions_cubit.dart';
import 'package:oceantodo/models/stikersmodel.dart';
import 'package:oceantodo/widgets/dragable_widget.dart';
import 'package:oceantodo/widgets/liststickerswidget.dart';
import 'package:oceantodo/widgets/targetwidget.dart';

class Stickerpage extends StatefulWidget {
  const Stickerpage({Key? key}) : super(key: key);

  @override
  State<Stickerpage> createState() => _StickerpageState();
}

class _StickerpageState extends State<Stickerpage> {
  double _height = 0.0;
  double _width = 0.0;
  List<Liststicker> allsticer = [];
  List<Liststicker> land = [];
  Offset position = Offset(0, 0);
  XFile? xFile;
  var image;
  final ImagePicker _picker = ImagePicker();
  final GlobalKey _draggableKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    context.read<StickersBloc>().add(StickerFectchEvent());
    getstickers();
  }

  void removeAll(Liststicker toRemove) {
    allsticer.removeWhere((sticker) => sticker.image == toRemove.image);
    land.removeWhere((sticker) => sticker.image == toRemove.image);
    //air.removeWhere((animal) => animal.imageUrl == toRemove.imageUrl);
  }

  getstickers() {
    context.read<StickersBloc>().stickerRepoImpl.fetchStiker().then((value) {
      if (value != null) {
        setState(() {
          allsticer = value.stkrdata!.lststicker!;
          print("images:${allsticer.first.image}");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Design"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25.0, top: 10.0),
            child: Text(
              "Save",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      body: BlocBuilder<StickersBloc, Stickerstate>(
        builder: (context, state) {
          if (state.stikerstatus == Stikerstatus.initial) {
            return Center(
              child: Text(
                "Initial",
                style: TextStyle(fontSize: 15.0, color: Colors.black),
              ),
            );
          }
          if (state.stikerstatus == Stikerstatus.error) {
            return Center(
              child: Text(
                "Error",
                style: TextStyle(fontSize: 15.0, color: Colors.black),
              ),
            );
          }
          if (state.stikerstatus == Stikerstatus.loading) {
            return Center(
              child: Text(
                "Loading....",
                style: TextStyle(fontSize: 15.0, color: Colors.black),
              ),
            );
          }

          return Column(children: [
            SizedBox(
              height: 10.0,
            ),
            Expanded(
                child: buildTarget(context,
                    stickers: land,
                    position: position,
                    onAccept: (data) => setState(() {
                          //  removeAll(data);
                          //context.watch<ActionsCubit>().delete("");
                          land.add(data);
                        }),
                    xFile: xFile)),
            Container(
              width: _width,
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              height: _height / 3,
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      getImage();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue.shade800,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.photo_library,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Gallery",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.0),
                            )
                          ]),
                      height: _height / 8,
                      width: _width / 5,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: _width,
                      child: ListView.builder(
                        itemBuilder: ((context, index) {
                          return Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Liststickerwidg(
                                  stickers: state.stikersmodel.stkrdata!
                                      .lststicker![index],
                                  onAccept: (data) {
                                    setState(() {
                                      //  removeAll(data);
                                      // context.watch<ActionsCubit>().delete("");
                                      allsticer.add(data);
                                    });
                                  }));
                        }),
                        itemCount:
                            state.stikersmodel.stkrdata!.lststicker!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        primary: false,
                      ),
                      height: _height / 10,
                    ),
                  )
                ],
              ),
            )
          ]);
        },
      ),
    );
  }

  void getImage() async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: Container(
                  padding: EdgeInsets.only(left: 20),
                  alignment: Alignment.center,
                  height: _height / 4,
                  width: _width / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Choose Image",
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          getimgFromgl();
                        },
                        child: Row(
                          children: [
                            Icon(Icons.photo_library),
                            SizedBox(
                              width: 30,
                            ),
                            Text("Gallery",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          getimgfromCm();
                        },
                        child: Row(
                          children: [
                            Icon(Icons.camera),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              "Camera",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            )
                          ],
                        ),
                      )
                    ],
                  )));
        });
  }

  void getimgFromgl() async {
    xFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  void getimgfromCm() async {
    xFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {});
  }
}
