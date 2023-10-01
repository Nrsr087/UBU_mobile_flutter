class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "UBU CLASSROOM",
    image: "images/image1.png",
    desc: "This is the Mobile Development course project 1145005-63.",
  ),
  OnboardingContents(
    title: "First Day after Midterm",
    image: "images/image2.png",
    desc:
        "https://pocketbase.io/docs/authentication.",
  ),
  OnboardingContents(
    title: "Homepage of UBU App",
    image: "images/image3.png",
    desc:
        "https://docs.flutter.dev/cookbook/forms/validation.",
  ),
];
