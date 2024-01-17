import 'package:flutter/material.dart';

class AmharicLetter {
  final String basicForm;
  final List<String> forms;

  AmharicLetter(this.basicForm, this.forms);
}

class AmharicKeyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
         
          SizedBox(
            height: 55,
            child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:  _keyboardRows[0].forms.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                itemBuilder: (context, index) {
                  final key = _keyboardRows[index];
                  return InkWell(
                    onTap: () {
                      // Handle key press
                      print('Pressed key: $key');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _keyboardRows[0].forms[index],
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ),
                  );
                },
              ),
          ),
          SizedBox(
            height: 150,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _keyboardRows.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 10,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemBuilder: (context, index) {
                final key = _keyboardRows[index];
                return InkWell(
                  onTap: () {
                    // Handle key press
                    print('Pressed key: $key');
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
];
