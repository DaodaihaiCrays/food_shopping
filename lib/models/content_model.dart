class UnboardingContent {
  final String image;
  final String title;
  final String description;

  UnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}
List<UnboardingContent> contents = [
  UnboardingContent(
    image: "images/screen1.png",
    title: "Select from our \n Best Menu",
    description: "Pick your food from our menu \n More than 35 times",
  ),
  UnboardingContent(
    image: "images/screen2.png",
    title: "Easy and only payment",
    description: "You can pay cash on delivery and also pay online",
  ),
  // UnboardingContent(
  //   image: "images/screen3.png",
  //   title: "Quick deliver to your door",
  //   description: "Deliver your food at your door step",
  // )
];