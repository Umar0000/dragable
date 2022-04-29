import 'package:dragable/model/animal_model.dart';

var listAnimal = [
  AnimalModel(imageUrl: "images/ic_bear.png", title: "Bear"),
  AnimalModel(imageUrl: "images/ic_chicken.png", title: "Chicken"),
  AnimalModel(imageUrl: "images/ic_dolphin.png", title: "Dolphin"),
  AnimalModel(imageUrl: "images/ic_goat.png", title: "Goat"),
  AnimalModel(imageUrl: "images/ic_parrot.png", title: "Parrot"),
  AnimalModel(imageUrl: "images/ic_duck.png", title: "Duck"),
];

var listAnimalTitle = [
  AnimalModel(title: "Bear"),
  AnimalModel(title: "Chicken"),
  AnimalModel(title: "Dolphin"),
  AnimalModel(title: "Goat"),
  AnimalModel(title: "Parrot"),
  AnimalModel(title: "Duck"),
];

void resetList() {
  var tempList = listAnimalTitle;
  listAnimalTitle.clear();
  listAnimalTitle = tempList;
}

String title = "";
