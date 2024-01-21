import 'package:bible_book_app/app/modules/detail/controllers/detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmharicLetter {
  final String basicForm;
  final List<String> forms;

  AmharicLetter(this.basicForm, this.forms);
}

final DetailController detailController = Get.find();

class AmharicKeyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
      init: DetailController(),
      initState: (_) {},
      builder: (_) {
        return Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 55,
                child: GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      detailController.selectedAmharicLetter?.forms.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        detailController.selectedAmharicLetter?.basicForm == '0'
                            ? 10
                            : 7,
                    mainAxisSpacing: 4.0, // Adjust the spacing here
                    crossAxisSpacing: 4.0, // Adjust the spacing here
                  ),
                  itemBuilder: (context, index) {
                    final key =
                        detailController.selectedAmharicLetter?.forms[index];
                    return InkWell(
                      onTap: () {
                        detailController.onKeyPressed(key!);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          key ?? "",
                          style: const TextStyle(fontSize: 18.0),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 235,
                child: GridView.builder(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _keyboardRows.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                    mainAxisSpacing: 4.0, // Adjust the spacing here
                    crossAxisSpacing: 4.0, // Adjust the spacing here
                  ),
                  itemBuilder: (context, index) {
                    final key = _keyboardRows[index];
                    return InkWell(
                      onTap: () {
                        if (key.basicForm == "AB") {
                          FocusScope.of(context)
                              .requestFocus(detailController.focusNode);
                        } else if (key.basicForm == '←') {
                          detailController.onBackSpaceKeyPressed();
                        } else if (key.basicForm == '#') {
                          detailController.onKeyPressed(key.basicForm);
                        } else if (key.basicForm == '↓') {
                          detailController.makeAmharicKeyboardInVisible();
                        } else if (key.basicForm == '―') {
                          detailController.onKeyPressed(" ");
                        } else if (key.basicForm == '@') {
                          detailController.onKeyPressed(key.basicForm);
                        } else {
                          detailController.setSelectedAmharicLetter(key);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          key.basicForm,
                          style: const TextStyle(fontSize: 18.0),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

final List<AmharicLetter> _keyboardRows = [
  AmharicLetter('ሀ', ['ሀ', 'ሁ', 'ሂ', 'ሃ', 'ሄ', 'ህ', 'ሆ']),
  AmharicLetter('ለ', ['ለ', 'ሉ', 'ሊ', 'ላ', 'ሌ', 'ል', 'ሎ']),
  AmharicLetter('ሐ', ['ሐ', 'ሑ', 'ሒ', 'ሓ', 'ሔ', 'ሕ', 'ሖ']),
  AmharicLetter('መ', ['መ', 'ሙ', 'ሚ', 'ማ', 'ሜ', 'ም', 'ሞ']),
  AmharicLetter('ሠ', ['ሠ', 'ሡ', 'ሢ', 'ሣ', 'ሤ', 'ሥ', 'ሦ']),
  AmharicLetter('ረ', ['ረ', 'ሩ', 'ሪ', 'ራ', 'ሬ', 'ር', 'ሮ']),
  AmharicLetter('ሰ', ['ሰ', 'ሱ', 'ሲ', 'ሳ', 'ሴ', 'ስ', 'ሶ']),
  AmharicLetter('ሸ', ['ሸ', 'ሹ', 'ሺ', 'ሻ', 'ሼ', 'ሽ', 'ሾ']),
  AmharicLetter('ቀ', ['ቀ', 'ቁ', 'ቂ', 'ቃ', 'ቄ', 'ቅ', 'ቆ']),
  AmharicLetter('በ', ['በ', 'ቡ', 'ቢ', 'ባ', 'ቤ', 'ብ', 'ቦ']),
  AmharicLetter('ተ', ['ተ', 'ቱ', 'ቲ', 'ታ', 'ቴ', 'ት', 'ቶ']),
  AmharicLetter('ቸ', ['ቸ', 'ቹ', 'ቺ', 'ቻ', 'ቼ', 'ች', 'ቾ']),
  AmharicLetter('ኀ', ['ኀ', 'ኁ', 'ኂ', 'ኃ', 'ኄ', 'ኅ', 'ኆ']),
  AmharicLetter('ነ', ['ነ', 'ኑ', 'ኒ', 'ና', 'ኔ', 'ን', 'ኖ']),
  AmharicLetter('ኘ', ['ኘ', 'ኙ', 'ኚ', 'ኛ', 'ኜ', 'ኝ', 'ኞ']),
  AmharicLetter('አ', ['አ', 'ኡ', 'ኢ', 'ኣ', 'ኤ', 'እ', 'ኦ']),
  AmharicLetter('ከ', ['ከ', 'ኩ', 'ኪ', 'ካ', 'ኬ', 'ክ', 'ኮ']),
  AmharicLetter('ኸ', ['ኸ', 'ኹ', 'ኺ', 'ኻ', 'ኼ', 'ኽ', 'ኾ']),
  AmharicLetter('ወ', ['ወ', 'ዉ', 'ዊ', 'ዋ', 'ዌ', 'ው', 'ዎ']),
  AmharicLetter('ዐ', ['ዐ', 'ዑ', 'ዒ', 'ዓ', 'ዔ', 'ዕ', 'ዖ']),
  AmharicLetter('ዘ', ['ዘ', 'ዙ', 'ዚ', 'ዛ', 'ዜ', 'ዝ', 'ዞ']),
  AmharicLetter('ዠ', ['ዠ', 'ዡ', 'ዢ', 'ዣ', 'ዤ', 'ዥ', 'ዦ']),
  AmharicLetter('የ', ['የ', 'ዩ', 'ዪ', 'ያ', 'ዬ', 'ይ', 'ዮ']),
  AmharicLetter('ደ', ['ደ', 'ዱ', 'ዲ', 'ዳ', 'ዴ', 'ድ', 'ዶ']),
  AmharicLetter('ጀ', ['ጀ', 'ጁ', 'ጂ', 'ጃ', 'ጄ', 'ጅ', 'ጆ']),
  AmharicLetter('ገ', ['ገ', 'ጉ', 'ጊ', 'ጋ', 'ጌ', 'ግ', 'ጎ']),
  AmharicLetter('ጠ', ['ጠ', 'ጡ', 'ጢ', 'ጣ', 'ጤ', 'ጥ', 'ጦ']),
  AmharicLetter('ጨ', ['ጨ', 'ጩ', 'ጪ', 'ጫ', 'ጬ', 'ጭ', 'ጮ']),
  AmharicLetter('ጰ', ['ጰ', 'ጱ', 'ጲ', 'ጳ', 'ጴ', 'ጵ', 'ጶ']),
  AmharicLetter('ጸ', ['ጸ', 'ጹ', 'ጺ', 'ጻ', 'ጼ', 'ጽ', 'ጾ']),
  AmharicLetter('ፀ', ['ፀ', 'ፁ', 'ፂ', 'ፃ', 'ፄ', 'ፅ', 'ፆ']),
  AmharicLetter('ፈ', ['ፈ', 'ፉ', 'ፊ', 'ፋ', 'ፌ', 'ፍ', 'ፎ']),
  AmharicLetter('ፐ', ['ፐ', 'ፑ', 'ፒ', 'ፓ', 'ፔ', 'ፕ', 'ፖ']),
  AmharicLetter('AB', []),
  AmharicLetter('0', ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']),
  AmharicLetter('―', []),
  AmharicLetter('@', []),
  AmharicLetter('#', []),
  AmharicLetter('←', []),
  AmharicLetter('↓', []),
  
];
