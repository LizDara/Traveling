import 'package:http/http.dart' as http;
import 'package:traveling/src/models/promotion_model.dart';
import 'package:traveling/src/providers/global.dart';

class PromotionProvider {
  Future<List<Promotion>> getPromotions() async {
    final response = await http.get(Uri.parse('$baseUrl/listar-promociones/'));

    if (response.statusCode == 200) {
      final promotions = promotionFromJson(response.body);
      return promotions;
    }
    return [];
  }
}
