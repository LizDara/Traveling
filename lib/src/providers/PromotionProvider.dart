import 'package:http/http.dart' as http;
import 'package:traveling/src/models/promotion_model.dart';
import 'package:traveling/src/providers/global.dart';

class PromotionProvider {
  final String _url = baseUrl;

  Future<List<Promotion>> getPromotions() async {
    final url = '$_url/listar-promociones/';

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final promotions = promotionFromJson(response.body);
      return promotions;
    }
    return [];
  }
}
