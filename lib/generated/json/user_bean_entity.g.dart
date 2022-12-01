import 'package:srbg/generated/json/base/json_convert_content.dart';
import 'package:srbg/entry/user_bean_entity.dart';

UserBeanEntity $UserBeanEntityFromJson(Map<String, dynamic> json) {
	final UserBeanEntity userBeanEntity = UserBeanEntity();
	final int? code = jsonConvert.convert<int>(json['code']);
	if (code != null) {
		userBeanEntity.code = code;
	}
	final String? message = jsonConvert.convert<String>(json['message']);
	if (message != null) {
		userBeanEntity.message = message;
	}
	final UserBeanData? data = jsonConvert.convert<UserBeanData>(json['data']);
	if (data != null) {
		userBeanEntity.data = data;
	}
	return userBeanEntity;
}

Map<String, dynamic> $UserBeanEntityToJson(UserBeanEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['code'] = entity.code;
	data['message'] = entity.message;
	data['data'] = entity.data?.toJson();
	return data;
}

UserBeanData $UserBeanDataFromJson(Map<String, dynamic> json) {
	final UserBeanData userBeanData = UserBeanData();
	final UserBeanDataLoginInfo? loginInfo = jsonConvert.convert<UserBeanDataLoginInfo>(json['loginInfo']);
	if (loginInfo != null) {
		userBeanData.loginInfo = loginInfo;
	}
	final List<UserBeanDataProjectResponse>? projectResponse = jsonConvert.convertListNotNull<UserBeanDataProjectResponse>(json['projectResponse']);
	if (projectResponse != null) {
		userBeanData.projectResponse = projectResponse;
	}
	return userBeanData;
}

Map<String, dynamic> $UserBeanDataToJson(UserBeanData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['loginInfo'] = entity.loginInfo?.toJson();
	data['projectResponse'] =  entity.projectResponse?.map((v) => v.toJson()).toList();
	return data;
}

UserBeanDataLoginInfo $UserBeanDataLoginInfoFromJson(Map<String, dynamic> json) {
	final UserBeanDataLoginInfo userBeanDataLoginInfo = UserBeanDataLoginInfo();
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		userBeanDataLoginInfo.userId = userId;
	}
	final String? userAccount = jsonConvert.convert<String>(json['userAccount']);
	if (userAccount != null) {
		userBeanDataLoginInfo.userAccount = userAccount;
	}
	final String? psw = jsonConvert.convert<String>(json['psw']);
	if (psw != null) {
		userBeanDataLoginInfo.psw = psw;
	}
	final String? userName = jsonConvert.convert<String>(json['userName']);
	if (userName != null) {
		userBeanDataLoginInfo.userName = userName;
	}
	final int? roleId = jsonConvert.convert<int>(json['roleId']);
	if (roleId != null) {
		userBeanDataLoginInfo.roleId = roleId;
	}
	final int? roleLevel = jsonConvert.convert<int>(json['roleLevel']);
	if (roleLevel != null) {
		userBeanDataLoginInfo.roleLevel = roleLevel;
	}
	final int? orgId = jsonConvert.convert<int>(json['orgId']);
	if (orgId != null) {
		userBeanDataLoginInfo.orgId = orgId;
	}
	final String? userPwd = jsonConvert.convert<String>(json['userPwd']);
	if (userPwd != null) {
		userBeanDataLoginInfo.userPwd = userPwd;
	}
	final String? token = jsonConvert.convert<String>(json['token']);
	if (token != null) {
		userBeanDataLoginInfo.token = token;
	}
	final int? controllable = jsonConvert.convert<int>(json['controllable']);
	if (controllable != null) {
		userBeanDataLoginInfo.controllable = controllable;
	}
	final List<String>? videoAreaList = jsonConvert.convertListNotNull<String>(json['videoAreaList']);
	if (videoAreaList != null) {
		userBeanDataLoginInfo.videoAreaList = videoAreaList;
	}
	return userBeanDataLoginInfo;
}

Map<String, dynamic> $UserBeanDataLoginInfoToJson(UserBeanDataLoginInfo entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['userId'] = entity.userId;
	data['userAccount'] = entity.userAccount;
	data['psw'] = entity.psw;
	data['userName'] = entity.userName;
	data['roleId'] = entity.roleId;
	data['roleLevel'] = entity.roleLevel;
	data['orgId'] = entity.orgId;
	data['userPwd'] = entity.userPwd;
	data['token'] = entity.token;
	data['controllable'] = entity.controllable;
	data['videoAreaList'] =  entity.videoAreaList;
	return data;
}

UserBeanDataProjectResponse $UserBeanDataProjectResponseFromJson(Map<String, dynamic> json) {
	final UserBeanDataProjectResponse userBeanDataProjectResponse = UserBeanDataProjectResponse();
	final String? projectId = jsonConvert.convert<String>(json['projectId']);
	if (projectId != null) {
		userBeanDataProjectResponse.projectId = projectId;
	}
	final String? projectNo = jsonConvert.convert<String>(json['projectNo']);
	if (projectNo != null) {
		userBeanDataProjectResponse.projectNo = projectNo;
	}
	final String? projectName = jsonConvert.convert<String>(json['projectName']);
	if (projectName != null) {
		userBeanDataProjectResponse.projectName = projectName;
	}
	final String? projectDesc = jsonConvert.convert<String>(json['projectDesc']);
	if (projectDesc != null) {
		userBeanDataProjectResponse.projectDesc = projectDesc;
	}
	final double? longitude = jsonConvert.convert<double>(json['longitude']);
	if (longitude != null) {
		userBeanDataProjectResponse.longitude = longitude;
	}
	final double? latitude = jsonConvert.convert<double>(json['latitude']);
	if (latitude != null) {
		userBeanDataProjectResponse.latitude = latitude;
	}
	final int? riskLevel = jsonConvert.convert<int>(json['riskLevel']);
	if (riskLevel != null) {
		userBeanDataProjectResponse.riskLevel = riskLevel;
	}
	final List<UserBeanDataProjectResponseTunnelList>? tunnelList = jsonConvert.convertListNotNull<UserBeanDataProjectResponseTunnelList>(json['tunnelList']);
	if (tunnelList != null) {
		userBeanDataProjectResponse.tunnelList = tunnelList;
	}
	return userBeanDataProjectResponse;
}

Map<String, dynamic> $UserBeanDataProjectResponseToJson(UserBeanDataProjectResponse entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['projectId'] = entity.projectId;
	data['projectNo'] = entity.projectNo;
	data['projectName'] = entity.projectName;
	data['projectDesc'] = entity.projectDesc;
	data['longitude'] = entity.longitude;
	data['latitude'] = entity.latitude;
	data['riskLevel'] = entity.riskLevel;
	data['tunnelList'] =  entity.tunnelList?.map((v) => v.toJson()).toList();
	return data;
}

UserBeanDataProjectResponseTunnelList $UserBeanDataProjectResponseTunnelListFromJson(Map<String, dynamic> json) {
	final UserBeanDataProjectResponseTunnelList userBeanDataProjectResponseTunnelList = UserBeanDataProjectResponseTunnelList();
	final String? tunnelId = jsonConvert.convert<String>(json['tunnelId']);
	if (tunnelId != null) {
		userBeanDataProjectResponseTunnelList.tunnelId = tunnelId;
	}
	final String? tunnelName = jsonConvert.convert<String>(json['tunnelName']);
	if (tunnelName != null) {
		userBeanDataProjectResponseTunnelList.tunnelName = tunnelName;
	}
	final dynamic? tunnelDesc = jsonConvert.convert<dynamic>(json['tunnelDesc']);
	if (tunnelDesc != null) {
		userBeanDataProjectResponseTunnelList.tunnelDesc = tunnelDesc;
	}
	final String? tunnelType = jsonConvert.convert<String>(json['tunnelType']);
	if (tunnelType != null) {
		userBeanDataProjectResponseTunnelList.tunnelType = tunnelType;
	}
	final List<UserBeanDataProjectResponseTunnelListAreaList>? areaList = jsonConvert.convertListNotNull<UserBeanDataProjectResponseTunnelListAreaList>(json['areaList']);
	if (areaList != null) {
		userBeanDataProjectResponseTunnelList.areaList = areaList;
	}
	return userBeanDataProjectResponseTunnelList;
}

Map<String, dynamic> $UserBeanDataProjectResponseTunnelListToJson(UserBeanDataProjectResponseTunnelList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['tunnelId'] = entity.tunnelId;
	data['tunnelName'] = entity.tunnelName;
	data['tunnelDesc'] = entity.tunnelDesc;
	data['tunnelType'] = entity.tunnelType;
	data['areaList'] =  entity.areaList?.map((v) => v.toJson()).toList();
	return data;
}

UserBeanDataProjectResponseTunnelListAreaList $UserBeanDataProjectResponseTunnelListAreaListFromJson(Map<String, dynamic> json) {
	final UserBeanDataProjectResponseTunnelListAreaList userBeanDataProjectResponseTunnelListAreaList = UserBeanDataProjectResponseTunnelListAreaList();
	final String? workAreaId = jsonConvert.convert<String>(json['workAreaId']);
	if (workAreaId != null) {
		userBeanDataProjectResponseTunnelListAreaList.workAreaId = workAreaId;
	}
	final String? workAreaName = jsonConvert.convert<String>(json['workAreaName']);
	if (workAreaName != null) {
		userBeanDataProjectResponseTunnelListAreaList.workAreaName = workAreaName;
	}
	final String? shortName = jsonConvert.convert<String>(json['shortName']);
	if (shortName != null) {
		userBeanDataProjectResponseTunnelListAreaList.shortName = shortName;
	}
	final String? stakeType = jsonConvert.convert<String>(json['stakeType']);
	if (stakeType != null) {
		userBeanDataProjectResponseTunnelListAreaList.stakeType = stakeType;
	}
	final double? startStake = jsonConvert.convert<double>(json['startStake']);
	if (startStake != null) {
		userBeanDataProjectResponseTunnelListAreaList.startStake = startStake;
	}
	final double? endStake = jsonConvert.convert<double>(json['endStake']);
	if (endStake != null) {
		userBeanDataProjectResponseTunnelListAreaList.endStake = endStake;
	}
	final String? workAreaType = jsonConvert.convert<String>(json['workAreaType']);
	if (workAreaType != null) {
		userBeanDataProjectResponseTunnelListAreaList.workAreaType = workAreaType;
	}
	final dynamic? mileageType = jsonConvert.convert<dynamic>(json['mileageType']);
	if (mileageType != null) {
		userBeanDataProjectResponseTunnelListAreaList.mileageType = mileageType;
	}
	final String? workAreaCode = jsonConvert.convert<String>(json['workAreaCode']);
	if (workAreaCode != null) {
		userBeanDataProjectResponseTunnelListAreaList.workAreaCode = workAreaCode;
	}
	final double? longitude = jsonConvert.convert<double>(json['longitude']);
	if (longitude != null) {
		userBeanDataProjectResponseTunnelListAreaList.longitude = longitude;
	}
	final double? latitude = jsonConvert.convert<double>(json['latitude']);
	if (latitude != null) {
		userBeanDataProjectResponseTunnelListAreaList.latitude = latitude;
	}
	return userBeanDataProjectResponseTunnelListAreaList;
}

Map<String, dynamic> $UserBeanDataProjectResponseTunnelListAreaListToJson(UserBeanDataProjectResponseTunnelListAreaList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['workAreaId'] = entity.workAreaId;
	data['workAreaName'] = entity.workAreaName;
	data['shortName'] = entity.shortName;
	data['stakeType'] = entity.stakeType;
	data['startStake'] = entity.startStake;
	data['endStake'] = entity.endStake;
	data['workAreaType'] = entity.workAreaType;
	data['mileageType'] = entity.mileageType;
	data['workAreaCode'] = entity.workAreaCode;
	data['longitude'] = entity.longitude;
	data['latitude'] = entity.latitude;
	return data;
}