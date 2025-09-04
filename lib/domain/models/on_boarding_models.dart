class OnBoardingModel {
  String image, title, subTitle;

  OnBoardingModel(this.image, this.title, this.subTitle);
}

class OnBoardingViewmodelObject {
  final OnBoardingModel onBoardingModel;
  final int numberOfSliders, currentIndex;

  OnBoardingViewmodelObject(
    this.onBoardingModel,
    this.numberOfSliders,
    this.currentIndex,
  );
}