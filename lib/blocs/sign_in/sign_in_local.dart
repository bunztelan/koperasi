import 'package:k2ms_v2/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  /// Set user data to local storage
  static void setUserLocalData(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('id', user.id.toString());
    prefs.setString('nip', user.nip.toString());
    prefs.setString('name', user.name.toString());
    prefs.setString('role', user.role.toString());
    prefs.setString('roleId', user.roleId.toString());
    prefs.setString('email', user.email.toString());
    prefs.setString('emailConfirmToken', user.emailConfirmToken.toString());
    prefs.setString('phoneNumber', user.phoneNumber.toString());
    prefs.setString('avatar', user.avatar.toString());
    prefs.setString('plantId', user.plantId.toString());
    prefs.setString('maritalStatus', user.maritalStatus.toString());
    prefs.setString('status', user.status.toString());
    prefs.setString('teamId', user.teamId.toString());
  }

  /// Get user data from local storage
  static Future<User> getUserLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      User user = User(
        id: int.parse(prefs.getString('id')),
        nip: prefs.getString('nip'),
        name: prefs.getString('name'),
        role: prefs.getString('role'),
        roleId: int.parse(prefs.getString('roleId')),
        email: prefs.getString('email'),
        emailConfirmToken: prefs.getString('emailConfirmToken'),
        phoneNumber: prefs.getString('phoneNumber'),
        avatar: prefs.getString('avatar'),
        plantId: int.parse(prefs.getString('plantId')),
        maritalStatus: prefs.getString('maritalStatus'),
        status: prefs.getString('status'),
        teamId: int.parse(prefs.getString('teamId')),
      );
      return user;
    } catch (e) {
      return null;
    }
  }

  /// Set user data to local storage
  static void setTokenLocalData(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('token', token);
  }

  /// Get user data from local storage
  static Future<String> getTokenLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      return prefs.getString('token');
    } catch (e) {
      return null;
    }
  }
}
