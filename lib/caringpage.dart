import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pet_care_app/data/database.dart';

import 'package:pet_care_app/models/caringModel.dart';
import 'package:pet_care_app/topWidget.dart';
import 'package:pet_care_app/utils/dialog_box.dart';


enum Type { vet, likes }

class CaringPage extends StatefulWidget {
  const CaringPage({super.key});

  @override
  State<CaringPage> createState() => _CaringPageState();
}

class _CaringPageState extends State<CaringPage> {

  //reference  box
  final _myBox = Hive.box('mybox');
  CaringDatabase cares = CaringDatabase();

  //Text Controller
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
        //if  it's first time, and  no  init data
    if (_myBox.get("VETS") == null || _myBox.get("LIKES") == null){
      cares.createInitialData();
    } else {
      cares.loadData();
    }

  }

  void _addVet(Type add) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          hint: "Enter ${add == Type.vet ? "Vet" : "Like"} Item",
          controller: _controller,
          onAdd: () => saveNewAdd(add),
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );

  }

  void saveNewAdd(Type add) {
    setState(() {
      if (add == Type.vet) {
        cares.vets.add(
            [ true,_controller.text]);
      } else {
        cares.likes.add(
            [false, _controller.text]);
      }
    });

    Navigator.of(context).pop();
    cares.updateDataBase();

  }

  void onDelete(Type add, int index) {
    setState(() {
      if (add == Type.vet) {
        cares.vets.removeAt(index);
      } else {
        cares.likes.removeAt(index);
      }
    });
    cares.updateDataBase();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.add_event,
          children: [
            SpeedDialChild(
                labelBackgroundColor: const Color(0xffCAA376),
                label: "Likes",
                onTap: () {
                  _addVet(Type.likes);
                }),
            SpeedDialChild(
                labelBackgroundColor: const Color(0xffCA7676),
                label: "Vet",
                onTap: () {
                  _addVet(Type.vet);
                }),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const TopWidget(subText: "", title: "Things to Know: "),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text("For the vet I need: "),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemCount: cares.vets.length,
                itemBuilder: (context, index) {
                  return CaringModel(
                    isVet: cares.vets[index][0],
                    name: cares.vets[index][1],
                    onDelete: (context) => onDelete(Type.vet,index),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text("I like:"),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: cares.likes.length,
              itemBuilder: (context, index) {
                return CaringModel(
                  isVet: cares.likes[index][0],
                  name: cares.likes[index][1],
                  onDelete: (context) => onDelete(Type.likes,index),

                );
              },
            )),
          ],
        ));
  }
}
