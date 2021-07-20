
class Usuario{
  Map<String,dynamic> user;
  Usuario({this.user});

  Map<String,dynamic> get itemKey {
    return {
      "Nombre": user["name"],
      "Ciudad": user["address"]["city"],
      "Email":user["email"],
      "Nombre de compañia": user["company"]["name"],
    };
  }

}