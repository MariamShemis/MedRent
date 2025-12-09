import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/routes/app_routes.dart';
import 'package:med_rent/features/onboarding/model/onboarding_model.dart';
import 'package:med_rent/features/onboarding/widgets/page_item_onboarding.dart';
import 'package:med_rent/l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int currentPage = 0;
  late final List<dynamic> onboardingList = OnboardingModel.getOnboarding(context);
  late final int lastPageIndex = onboardingList.length - 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void goToPreviousPage() {
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipOnboarding() {
    Navigator.pushReplacementNamed(context, AppRoutes.startScreen);
  }

  void goToNextPage() {
    if (currentPage < lastPageIndex) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.startScreen);
    }
  }


  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final isFirstPage = currentPage == 0;
    final isLastPage = currentPage == lastPageIndex;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!isFirstPage)
                    IconButton(
                      onPressed: goToPreviousPage,
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: ColorManager.secondary,
                      ),
                    )
                  else
                    SizedBox(width: 48.w),
                  if (!isLastPage)
                    TextButton(
                      onPressed: skipOnboarding,
                      child: Text(
                        appLocalizations.skip,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: ColorManager.secondary,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 50.h),
              Expanded(  
               // height: 350.h,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboardingList.length,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value; // مهم جدا
                    });
                  },
                  itemBuilder: (context, index) {
                    return PageItemOnboarding(
                      model: onboardingList[index],
                    );
                  },
                ),
              ),
              SizedBox(height: 40.h),
              Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: onboardingList.length,
                  effect: const WormEffect(
                    activeDotColor: ColorManager.darkBlue,
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                ),
              ),
              SizedBox(height: 80.h),
              ElevatedButton(
                onPressed: goToNextPage,
                child: Text(isLastPage ? appLocalizations.getStarted : appLocalizations.next),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
