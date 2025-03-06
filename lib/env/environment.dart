

class Environment{

  static const String endpointBase = "http://127.0.0.1:8000";
  static const String endpointApi = "http://127.0.0.1:8000/api";

}


void main(){
  print('${Environment.endpointApi}/google-login');
}