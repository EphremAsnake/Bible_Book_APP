abstract class AppTranslation {
  static Map<String, Map<String, String>> translationsKeys = {
    "en": en,
    "amh": amh,
  };
}

final Map<String, String> en = {
  'result': 'Results: ',
  'day': "Awesome day..."
};

final Map<String, String> amh = {
  'result': 'የተገኙ ዉጤትዎች ብዛት: ',
  'day': "সন্ত্রস্ত দিন..."
};
