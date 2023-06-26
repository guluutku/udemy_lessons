import 'package:uuid/uuid.dart';

final uuid = Uuid();

class FavoritePlace {
  FavoritePlace({
    required this.title,
  }) : id = uuid.v4();

  final String id;
  final String title;
}
