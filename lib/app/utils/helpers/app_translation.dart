import 'package:get/get.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        "amh_ET": amh,
      };
}

final Map<String, String> en = {
  'searchResult': 'Results: ',
  'book': "Holy Bible",
  'ot': 'Old Testament',
  'nt': 'New Testament',
  'chapters': 'Chapter',
  'search': 'Search',
  'settings': 'Settings',
  'about': "About",
  'privacy_policy': 'Privacy Policy',
  'all': 'All',
  'every_word': 'Every Word',
  'exactly': 'Exactly',
  "change_language": "Change Language To Amharic",
};

final Map<String, String> amh = {
  'searchResult': 'የተገኙ ዉጤትዎች ብዛት: ',
  'book': "መጽሐፍ ቅዱስ",
  'ot': 'ብሉይ ኪዳን',
  'nt': 'አዲስ ኪዳን',
  'chapters': "ምዕራፍ",
  'search': 'ፍልግ',
  'every_word': 'ሁሉንም ቃላት',
  'exactly': 'እንቅጩን',
  'all': 'በሁሉም',
  'settings': 'መቼት',
  'about': "ስለ",
  'privacy_policy': 'ግለሰባዊነት',
  "change_language": "ቋንቋ ወደ እንግሊዝኛ ቀይር"
};
