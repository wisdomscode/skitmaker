// This is the API class that is used by flutter to get items from the api url

class API {
  // to get linux: hostname -I, or ifconfig, window: ipconfig
  static const hostConnect = 'http://192.168.43.137/php/api_skitmaker';
  static const hostConnectUser = "$hostConnect/users";

  // register user
  static const validateEmail = "$hostConnect/users/validate_email.php";
  static const registerUser = "$hostConnect/users/register.php";
  static const loginUser = "$hostConnect/users/login.php";
}
