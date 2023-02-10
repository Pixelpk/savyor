import '../../application/network/external_values/iExternalValue.dart';
import '../../di/di.dart';

class GetUserProfile {
  String? profilePic;
  bool? error;
  String? msg;
  IExternalValues iExternalValues = inject();
  GetUserProfile({this.profilePic, this.error, this.msg});

  GetUserProfile.fromJson(Map<String, dynamic> json) {
    profilePic = "${iExternalValues.getBaseUrl()}${json['profile_pic']}";
    error = json['error'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile_pic'] = profilePic;
    data['error'] = error;
    data['msg'] = msg;
    return data;
  }
}
