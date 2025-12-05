import 'package:med_rent/core/constants/assets_manager.dart';

class OnboardingModel {
  final String name;
  final String image;
  final String description;

  OnboardingModel({
    required this.name,
    required this.image,
    required this.description,
  });

  static List<OnboardingModel> onboardings = [
    OnboardingModel(
      name: "Book the nearest hospital easily",
      image: ImageAssets.onboarding1,
      description:
          "Locate your area and find the best and nearest hospitals in a few simple steps.",
    ),
    OnboardingModel(
      name: "Rent Medical Equipment Anytime",
      image: ImageAssets.onboarding2,
      description:
          "Choose the right device, see the details, and book it immediately with delivery to your doorstep.",
    ),
    OnboardingModel(
      name: "Smart Assistant for Your Symptoms",
      image: ImageAssets.onboarding3,
      description:
          "Enter your symptoms and the smart assistant will guide you to the appropriate section for your condition.",
    ),

  ];
}
final List<Map<String, String>> onboardingPages = [
  {
    'image': ImageAssets.onboarding1,
    'title': 'Find Events That Inspire You',
    'desc':
    'Dive into a world of events crafted to fit your unique interests. Whether you\'re into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone.',
  },
  {
    'image':ImageAssets.onboarding2,
    'title': 'Effortless Event Planning',
    'desc':
    'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we\'ve got you covered.',
  },
  {
    'image': ImageAssets.onboarding3,
    'title': 'Connect with Friends & Share Moments',
    'desc':
    'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together.',
  },
];

