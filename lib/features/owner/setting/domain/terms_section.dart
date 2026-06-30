/// A single section inside the Terms & Conditions document.
class TermsSection {
  final int number;
  final String title;
  final List<String> points;

  const TermsSection({
    required this.number,
    required this.title,
    required this.points,
  });
}
