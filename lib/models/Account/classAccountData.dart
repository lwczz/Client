class classAccountClientData{
  String clientID;
  String clientName;
  String clientNRIC;
  String clientEmail;
  String clientPhoneNumber;
  String clientPassword;

}
class classAccountEwalletData{

  String eWallet;

}

class Data {
  final String id;


  Data({this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = this.id;

    return data;
  }
}