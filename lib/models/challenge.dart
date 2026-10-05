enum ChallengeCategory {
  romantico,
  divertido,
  salir,
  casa,
  pregunta,
  atrevido,
}

class Challenge {
  final String id;
  final String title;
  final String description;
  final ChallengeCategory category;

  const Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
  });
}