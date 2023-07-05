import 'dart:io';

import 'package:udemy_lessons/models/location_model.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class FavoritePlace {
  FavoritePlace({
    required this.image,
    required this.title,
    required this.locationModel,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final File image;
  final LocationModel locationModel;
}
