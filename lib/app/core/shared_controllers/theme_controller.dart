import 'package:bible_book_app/app/core/shared_controllers/master_data_controller.dart';
import 'package:bible_book_app/app/utils/helpers/app_colors.dart';
import 'package:bible_book_app/app/utils/helpers/hex_color_helper.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final MasterDataController controller = Get.find();
  Rx<ThemeDataModel?> themeData = Rx<ThemeDataModel?>(null);

  void getThemeData() {
    final theme = ThemeDataModel(
      whiteColor: HexColor("#ffffff"),
      backgroundColor: HexColor("#FEFEFE"),
      primaryColor: HexColor("#7B5533"),
      lightPrimary: HexColor('#997252'),
      blackColor: HexColor("#000000"),
      grayTextColor: HexColor(
        "#747475",
      ),
      shadowColor: HexColor("#EEEDED"),
      splashColor: HexColor("#AF703A"),
      errorColor: HexColor("#FF1100"),
      lightGrey: HexColor("#cccbc8"),
      numbersColor: HexColor("#FF922D26"),
      verseColor: HexColor("#000000"),
      cardColor: HexColor("#ffffff"),
      keyboardColor: HexColor("#ebebeb"),
    );
    themeData.value = theme;
  }

  void getDarkThemeData() {
    final theme = ThemeDataModel(
      whiteColor: HexColor("#EEEEEE"),
      backgroundColor: HexColor("#31363F"),
      primaryColor: HexColor("#76ABAE"),
      lightPrimary: HexColor('#85c3c7'),
      blackColor: HexColor("#000000"),
      grayTextColor: HexColor(
        "#626367",
      ),
      shadowColor: HexColor("#31363F"),
      splashColor: HexColor("#AF703A"),
      errorColor: HexColor("#FF1100"),
      lightGrey: HexColor("#626367"),
      numbersColor: HexColor("#76ABAE"),
      verseColor: HexColor("#EEEEEE"),
      cardColor:HexColor("#4a515e"),
       keyboardColor: HexColor("#4a515e"),
    );
    themeData.value = theme;
  }
}
