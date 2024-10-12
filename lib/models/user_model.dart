class UserModel {
  
  final String? id;
  final String usernName;
  final String email;

  const UserModel ({
    this.id,
    required this.usernName,
    required this.email,
  });

  Map<String, dynamic> toFirestore(){
    return{
      "Nombre": usernName,
      "Correo": email,
    };
  }
}