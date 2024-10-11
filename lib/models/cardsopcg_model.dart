class CardsopcgModel {
  
  final String? id;
  final String cardName;
  final String cardExpansion;
  final String cardColor;
  final String cardType;
  final String cardIllustration;
  final String imageUrl;

  const CardsopcgModel({
    this.id,
    required this.cardName,
    required this.cardExpansion,
    required this.cardColor,
    required this.cardType,
    required this.cardIllustration,
    required this.imageUrl,
  });

  toJson(){
    return{
      "Nombre":       cardName,
      "Expansion":    cardExpansion,
      "Color":        cardColor,
      "Tipo":         cardType,
      "Ilustracion":  cardIllustration,
      "Imagen": imageUrl
    };
  }
}