class CardsmylModel {
  
  final String? id;
  final String cardName;
  final String cardExpansion;
  final String cardType;
  final String cardRace;
  final String cardFrequency;
  final String cardCost;
  final String cardStr;
  final String imageUrl;

  const CardsmylModel({
    this.id,
    required this.cardName,
    required this.cardExpansion,
    required this.cardType,
    required this.cardRace,
    required this.cardFrequency,
    required this.cardCost,
    required this.cardStr,
    required this.imageUrl,
  });

  toJson(){
    return{
      "Nombre": cardName,
      "Expansion": cardExpansion,
      "Tipo": cardType,
      "Raza": cardRace,
      "Frecuencia": cardFrequency,
      "Coste": cardCost,
      "Fuerza": cardStr,
      "Imagen": imageUrl,
    };
  }
}