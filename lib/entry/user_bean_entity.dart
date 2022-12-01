import 'package:srbg/generated/json/base/json_field.dart';
import 'package:srbg/generated/json/user_bean_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class UserBeanEntity {

	int? code;
	String? message;
	UserBeanData? data;
  
  UserBeanEntity();

  factory UserBeanEntity.fromJson(Map<String, dynamic> json) => $UserBeanEntityFromJson(json);

  Map<String, dynamic> toJson() => $UserBeanEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserBeanData {

	UserBeanDataLoginInfo? loginInfo;
	List<UserBeanDataProjectResponse>? projectResponse;
  
  UserBeanData();

  factory UserBeanData.fromJson(Map<String, dynamic> json) => $UserBeanDataFromJson(json);

  Map<String, dynamic> toJson() => $UserBeanDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserBeanDataLoginInfo {

	int? userId;
	String? userAccount;
	String? psw;
	String? userName;
	int? roleId;
	int? roleLevel;
	int? orgId;
	String? userPwd;
	String? token;
	int? controllable;
	List<String>? videoAreaList;
  
  UserBeanDataLoginInfo();

  factory UserBeanDataLoginInfo.fromJson(Map<String, dynamic> json) => $UserBeanDataLoginInfoFromJson(json);

  Map<String, dynamic> toJson() => $UserBeanDataLoginInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserBeanDataProjectResponse {

	String? projectId;
	String? projectNo;
	String? projectName;
	String? projectDesc;
	double? longitude;
	double? latitude;
	int? riskLevel;
	List<UserBeanDataProjectResponseTunnelList>? tunnelList;
  
  UserBeanDataProjectResponse();

  factory UserBeanDataProjectResponse.fromJson(Map<String, dynamic> json) => $UserBeanDataProjectResponseFromJson(json);

  Map<String, dynamic> toJson() => $UserBeanDataProjectResponseToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserBeanDataProjectResponseTunnelList {

	String? tunnelId;
	String? tunnelName;
	dynamic tunnelDesc;
	String? tunnelType;
	List<UserBeanDataProjectResponseTunnelListAreaList>? areaList;
  
  UserBeanDataProjectResponseTunnelList();

  factory UserBeanDataProjectResponseTunnelList.fromJson(Map<String, dynamic> json) => $UserBeanDataProjectResponseTunnelListFromJson(json);

  Map<String, dynamic> toJson() => $UserBeanDataProjectResponseTunnelListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UserBeanDataProjectResponseTunnelListAreaList {

	String? workAreaId;
	String? workAreaName;
	String? shortName;
	String? stakeType;
	double? startStake;
	double? endStake;
	String? workAreaType;
	dynamic mileageType;
	String? workAreaCode;
	double? longitude;
	double? latitude;
  
  UserBeanDataProjectResponseTunnelListAreaList();

  factory UserBeanDataProjectResponseTunnelListAreaList.fromJson(Map<String, dynamic> json) => $UserBeanDataProjectResponseTunnelListAreaListFromJson(json);

  Map<String, dynamic> toJson() => $UserBeanDataProjectResponseTunnelListAreaListToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}