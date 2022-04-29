import 'package:dragable/model/animal_model.dart';
import 'package:dragable/mouk_data/mouk_data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
        home: MyApp(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/myApp',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/myApp': (context) => MyApp(),
        }),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Expanded(
                          child: Center(
                              child: Text(
                        "LongPress to Drag Animal",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.center,
                      ))),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              listAnimalTitle = [
                                AnimalModel(title: "Bear"),
                                AnimalModel(title: "Chicken"),
                                AnimalModel(title: "Dolphin"),
                                AnimalModel(title: "Goat"),
                                AnimalModel(title: "Parrot"),
                                AnimalModel(title: "Duck"),
                              ];
                            });
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => MyApp(),
                                ),
                                (route) => false);
                          },
                          icon: Icon(Icons.refresh))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: GridView.builder(
                        itemCount: listAnimal.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10),
                        itemBuilder: (c, i) {
                          title = listAnimal[i].title ?? "";

                          return LongPressDraggable(
                              dragAnchorStrategy: pointerDragAnchorStrategy,
                              data: listAnimal[i],
                              child: UpListofAnimal(index: i),
                              feedback: DragView(index: i));
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Drop Animal Here ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: GridView.builder(
                        itemCount: listAnimalTitle.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10),
                        itemBuilder: (c, i) {
                          return DragTarget<AnimalModel>(
                              builder: (cxt, cadiateItem, rejected) {
                            print(listAnimalTitle[i].title);
                            return DownDragAnimalList(
                              animalModel: listAnimalTitle[i],
                              index: i,
                              highlighted: cadiateItem.isNotEmpty,
                              hasItems: listAnimalTitle.isNotEmpty,
                            );
                          }, onAccept: (item) {
                            setState(() {
                              if (item.title == listAnimalTitle[i].title) {
                                listAnimalTitle[i] = item;
                              }
                            });
                          });
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DownDragAnimalList extends StatelessWidget {
  final AnimalModel animalModel;
  final bool highlighted;
  final bool hasItems;
  final int index;
  DownDragAnimalList({
    Key? key,
    required this.highlighted,
    required this.hasItems,
    required this.animalModel,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: highlighted
            ? animalModel.title == title
                ? Colors.green
                : Colors.red
            : Colors.transparent,
        border: const Border(
          top: BorderSide(width: 1),
          right: BorderSide(width: 1),
          bottom: BorderSide(width: 1),
          left: BorderSide(width: 1),
        ),
      ),
      child: Column(
        children: [
          Text(animalModel.title ?? ""),
          Visibility(
              visible: hasItems,
              maintainState: true,
              maintainAnimation: true,
              maintainSize: true,
              child: animalModel.imageUrl != null
                  ? Image.asset(
                      animalModel.imageUrl ?? "",
                      width: 100,
                      height: 100,
                    )
                  : Container())
        ],
      ),
    );
  }
}

class UpListofAnimal extends StatelessWidget {
  final int index;
  const UpListofAnimal({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1),
          right: BorderSide(width: 1),
          bottom: BorderSide(width: 1),
          left: BorderSide(width: 1),
        ),
      ),
      child: Column(
        children: [
          Text(listAnimal[index].title ?? ""),
          Visibility(
              visible: true,
              maintainState: true,
              maintainAnimation: true,
              maintainSize: true,
              child: Image.asset(
                listAnimal[index].imageUrl ?? " ",
                width: 100,
                height: 100,
              ))
        ],
      ),
    );
  }
}

class DragView extends StatefulWidget {
  final int index;
  const DragView({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<DragView> createState() => _DragViewState();
}

class _DragViewState extends State<DragView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = listAnimal[widget.index].title ?? "";
    print(title);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
            visible: true,
            maintainState: true,
            maintainAnimation: true,
            maintainSize: true,
            child: Image.asset(
              listAnimal[widget.index].imageUrl ?? " ",
              width: 80,
              height: 80,
            ))
      ],
    );
  }
}
