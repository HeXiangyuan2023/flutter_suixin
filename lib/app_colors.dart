import 'dart:ui';

class AppColors {
  // XT Colors
  final Color main = const Color(0xFFFFBE40);
  final Color mainA40 = const Color(0x66FFBE40);
  final Color mainA20 = const Color(0x33FFBE40);
  final Color mainA10 = const Color(0x1AFFBE40);
  final Color green = const Color(0xFF17C186);
  final Color greenA40 = const Color(0x6617C186);
  final Color greenA20 = const Color(0x3317C186);
  final Color greenA10 = const Color(0x1A17C186);

  final Color red = const Color(0xFFFD5760);
  final Color redA40 = const Color(0x66FD5760);
  final Color redA20 = const Color(0x33FD5760);
  final Color redA10 = const Color(0x1AFD5760);
  final Color white = const Color(0xFFFFFFFF);
  final Color black = const Color(0xFF2D2D2E);
  final Color blackA20 = const Color(0x33000000);
  final Color blue = const Color(0xFF238FDD);
  final Color purple = const Color(0xFF5C00F3);
  final Color orange = const Color(0xFFFF7A00);
  final Color textBlack = const Color(0xCC000000);
  final Color textWhite = const Color(0xFFFFFFFF);
  final Color textBlackA40 = const Color(0x66000000);
  final Color textWhiteA40 = const Color(0x66FFFFFF);
  final Color maskBackground = const Color(0x66000000);
  final Color buttonBorder = const Color(0xFFC4C4C4);
  final Color toastBackground = const Color(0xBF000000);
  final Color blackShadow = const Color(0x0D000000);


  late Color textPrimaryWhiteBlack;
  late Color textSecondaryWhiteBlack;
  late Color textTertiaryWhiteBlack;
  late Color textPromptWhiteBlack;

  late Color backgroundPrimary;
  late Color backgroundSecondary;
  late Color backgroundTertiary;
  late Color textPrimary;
  late Color textSecondary;
  late Color textTertiary;
  late Color textPrompt;
  late Color inputBackground;
  late Color dialogBackground;
  late Color whiteBlack;
  late Color whiteBlackA80;
  late Color whiteBlackA60;
  late Color whiteBlackA40;
  late Color whiteBlackA20;
  late Color whiteBlackA8;
  late Color blackWhite;
  late Color blackWhiteA80;
  late Color blackWhiteA60;
  late Color blackWhiteA40;
  late Color blackWhiteA20;
  late Color blackWhiteA8;

  static final AppColors _dark = AppColors._darkInternal();
  static final AppColors _light = AppColors._lightInternal();

  AppColors._darkInternal() {
    backgroundPrimary = const Color(0xFF262626);
    backgroundSecondary = const Color(0xFF19191E);
    backgroundTertiary = const Color(0xFF2D2D2E);
    textPrimary = const Color(0xFFFFFFFF);
    textSecondary = const Color(0x99FFFFFF);
    textTertiary = const Color(0xCCFFFFFF);
    textPrompt = const Color(0x33FFFFFF);
    blackWhite = const Color(0xFFFFFFFF);
    blackWhiteA40 = const Color(0x66FFFFFF);
    blackWhiteA60 = const Color(0x99FFFFFF);
    blackWhiteA80 = const Color(0xCCFFFFFF);
    blackWhiteA8 = const Color(0x14FFFFFF);
    blackWhiteA20 = const Color(0x33FFFFFF);
    dialogBackground = const Color(0xF22D2D2E);
    inputBackground = const Color(0x08FFFFFF);
    textPrimaryWhiteBlack = const Color(0xCC000000);
    textPromptWhiteBlack = const Color(0x33000000);
    textSecondaryWhiteBlack = const Color(0x99000000);
    textTertiaryWhiteBlack = const Color(0x66000000);
    whiteBlack = const Color(0xFF000000);
    whiteBlackA20 = const Color(0x33000000);
    whiteBlackA40 = const Color(0x66000000);
    whiteBlackA60 = const Color(0x99000000);
    whiteBlackA8 = const Color(0x14000000);
    whiteBlackA80 = const Color(0xCC000000);
  }

  AppColors._lightInternal() {
    backgroundPrimary = const Color(0xFFFFFFFF);
    backgroundSecondary = const Color(0xFFFFFFFF);
    backgroundTertiary = const Color(0xFFF8F8F8);
    textPrimary = const Color(0xCC000000);
    textSecondary = const Color(0x99000000);
    textTertiary = const Color(0x66000000);
    textPrompt = const Color(0x99000000);
    blackWhite = const Color(0xFF000000);
    blackWhiteA40 = const Color(0x66000000);
    blackWhiteA60 = const Color(0x99000000);
    blackWhiteA80 = const Color(0xCC000000);
    blackWhiteA8 = const Color(0x14000000);
    blackWhiteA20 = const Color(0x33000000);
    dialogBackground = const Color(0xF2FFFFFF);
    inputBackground = const Color(0x08000000);
    textPrimaryWhiteBlack = const Color(0xFFFFFFFF);
    textPromptWhiteBlack = const Color(0x33FFFFFF);
    textSecondaryWhiteBlack = const Color(0x99FFFFFF);
    textTertiaryWhiteBlack = const Color(0x66FFFFFF);
    whiteBlack = const Color(0xFFFFFFFF);
    whiteBlackA20 = const Color(0x33FFFFFF);
    whiteBlackA40 = const Color(0x66FFFFFF);
    whiteBlackA60 = const Color(0x99FFFFFF);
    whiteBlackA8 = const Color(0x14FFFFFF);
    whiteBlackA80 = const Color(0xCCFFFFFF);
  }

  factory AppColors.light() => AppColors._light;

  factory AppColors.dark() => AppColors._dark;
}
