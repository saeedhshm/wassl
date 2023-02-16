class CustomException implements Exception{

  String errorMessage ;
  CustomException({this.errorMessage = 'something_wrong_try_again'});
}