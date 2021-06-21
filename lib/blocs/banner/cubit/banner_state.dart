part of 'banner_cubit.dart';

abstract class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object> get props => [];
}

class BannerInitialState extends BannerState {}

class BannerLoadingState extends BannerState {}

class BannerErrorState extends BannerState {
  final String message;

  BannerErrorState({this.message});

  List<Object> get props => [message];
}

class BannerLoadedState extends BannerState {
  final List<BannerModel> banners;

  BannerLoadedState({this.banners});

  List<Object> get props => [banners];
}
