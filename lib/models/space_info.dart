import 'package:parking_spot_frontend/models/book_mark_space.dart';

class FloorInfo {
  int? id;
  String? name;
  int? locationId;
  int? mapId;
  int? total;
  int? parkedNum;

  FloorInfo(
      {this.id,
      this.name,
      this.locationId,
      this.mapId,
      this.total,
      this.parkedNum});

  FloorInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    locationId = json['location_id'];
    mapId = json['map_id'];
    total = json['total'];
    parkedNum = json['parked_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['location_id'] = locationId;
    data['map_id'] = mapId;
    data['total'] = total;
    data['parked_num'] = parkedNum;
    return data;
  }

  @override
  String toString() {
    return "id : $id\n"
        "name : $name\n"
        "location_id : $locationId\n"
        "map_id : $mapId\n"
        "total : $total\n"
        "parked_num : $parkedNum";
  }
}

class SpaceInfo {
  var spaces = <FloorInfo>[];
  SpaceInfo(this.spaces);

  factory SpaceInfo.fromJson(List<dynamic> json) {
    List<FloorInfo> spaces = json.map((e) => FloorInfo.fromJson(e)).toList();
    return SpaceInfo(spaces);
  }

  FloorInfo? getFloorInfo(BookMarkSpace? selected) {
    if (selected != null) {
      for (int i = 0; i < spaces.length; i++) {
        if (spaces[i].id == selected.id) {
          return spaces[i];
        }
      }
    }
    return null;
  }
}
