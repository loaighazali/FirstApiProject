
class ApiSetting {

  static const _baseUrl = "http://demo-api.mr-dev.tech/" ;
  static const _imageUrl = _baseUrl + "images/" ;
  static const _apiUrl = _baseUrl + "api/" ;

  static getImageUrl(String image){
    return _imageUrl+image;
  }

  static const users = _apiUrl + 'users' ;
  static const categories = _apiUrl + 'categories';
  static const register = _apiUrl + 'students/auth/register';
  static const login = _apiUrl + 'students/auth/login';
  static const logout = _apiUrl + 'students/auth/logout';
  static const forgetPassword = _apiUrl + 'auth/forget-password';
  static const resetPassword = _apiUrl + 'students/auth/reset-password';

  static const images = _apiUrl + 'student/images/{id}';
}