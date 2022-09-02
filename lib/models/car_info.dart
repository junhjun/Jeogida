class CarInfo {
  int? locationId;
  String? locationName;
  int? locationTotal;
  int? mapId;
  String? mapName;
  String? mapPath;
  String? parkingInfoChangedAt;
  int? parkingInfoId;
  bool? parkingInfoIsParked;
  int? parkingInfoNumber;
  int? parkingLotId;
  String? parkingLotName;
  int? parkingLotParkedNum;
  int? parkingLotTotal;

  CarInfo(
      {this.locationId,
      this.locationName,
      this.locationTotal,
      this.mapId,
      this.mapName,
      this.mapPath,
      this.parkingInfoChangedAt,
      this.parkingInfoId,
      this.parkingInfoIsParked,
      this.parkingInfoNumber,
      this.parkingLotId,
      this.parkingLotName,
      this.parkingLotParkedNum,
      this.parkingLotTotal});

  CarInfo.fromJson(Map<String, dynamic> json) {
    locationId = json['location_id'];
    locationName = json['location_name'];
    locationTotal = json['location_total'];
    mapId = json['map_id'];
    mapName = json['map_name'];
    mapPath = json['map_path'];
    parkingInfoChangedAt = json['parking_info_changed_at'];
    parkingInfoId = json['parking_info_id'];
    parkingInfoIsParked = json['parking_info_is_parked'];
    parkingInfoNumber = json['parking_info_number'];
    parkingLotId = json['parking_lot_id'];
    parkingLotName = json['parking_lot_name'];
    parkingLotParkedNum = json['parking_lot_parked_num'];
    parkingLotTotal = json['parking_lot_total'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['location_id'] = locationId;
    data['location_name'] = locationName;
    data['location_total'] = locationTotal;
    data['map_id'] = mapId;
    data['map_name'] = mapName;
    data['map_path'] = mapPath;
    data['parking_info_changed_at'] = parkingInfoChangedAt;
    data['parking_info_id'] = parkingInfoId;
    data['parking_info_is_parked'] = parkingInfoIsParked;
    data['parking_info_number'] = parkingInfoNumber;
    data['parking_lot_id'] = parkingLotId;
    data['parking_lot_name'] = parkingLotName;
    data['parking_lot_parked_num'] = parkingLotParkedNum;
    data['parking_lot_total'] = parkingLotTotal;
    return data;
  }

  @override
  String toString() {
    var result = 'location_id : $locationId\n'
        'location_name : $locationName\n'
        'location_total : $locationTotal\n'
        'map_id : $mapId,\n'
        'map_name : $mapName,\n'
        'map_path : $mapPath,\n'
        'parking_info_changed_at : $parkingInfoChangedAt\n'
        'parking_info_id : $parkingInfoId\n'
        'parking_info_is_parked : $parkingInfoIsParked\n'
        'parking_info_number : $parkingInfoNumber\n'
        'parking_lot_id : $parkingLotId\n'
        'parking_lot_name : $parkingLotName\n'
        'parking_lot_parked_num : $parkingLotParkedNum\n'
        'parking_lot_total : $parkingLotTotal\n';
    return result;
  }
}
