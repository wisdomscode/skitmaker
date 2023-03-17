class OnboardingContent {
  String image;
  String title;
  String description;

  OnboardingContent(
      {required this.image, required this.title, required this.description});
}

List<OnboardingContent> contents = [
  OnboardingContent(
    title: 'Entertainment is Life',
    image: 'images/soccer_banner.png',
    description: "Dummy text of the sample text company"
        "The test of the faith is the qualification for greatness"
        "the brown big fox jumped over the lazy brown dog",
  ),
  OnboardingContent(
    title: 'The World is your Stage',
    image: 'images/sabinus.png',
    description: "Dummy text of the sample text company"
        "The test of the faith is the qualification for greatness"
        "the brown big fox jumped over the lazy brown dog",
  ),
  OnboardingContent(
    title: 'Ride to Greatness',
    image: 'images/davido.jpg',
    description: "Dummy text of the sample text company"
        "The test of the faith is the qualification for greatness"
        "the brown big fox jumped over the lazy brown dog",
  ),
];
