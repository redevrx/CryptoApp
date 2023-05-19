import 'package:crypto_search/model/crypto/bpi.dart';
import 'package:crypto_search/model/crypto/crypto_data.dart';
import 'package:crypto_search/provider/base_crypto_provider.dart';
import 'package:crypto_search/provider/crypto/crypto_event.dart';
import 'package:crypto_search/service/crypto_service.dart';
import 'package:crypto_search/utils/extension.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class CryptoProvider extends BaseCryptoProvider {
  final _service = GetIt.instance.get<CryptoService>();

  @override
  void onEvent<CryptoEvent>({required CryptoEvent event}) {
    switch (event) {
      case InitDatabase _:
        initDatabase();
        break;
      case FetchCrypto _:
        fetchData();
        break;
      case FetchHistoryCrypto _:
        fetchHistory();
        break;
      case ConvertToBTC _:
        convertToBtc(event.rate);
        break;
      case PriceInputChange _:
        onPriceChange(event.price);
        break;
      case ClearPrice _:
        onClearPrice();
        break;
    }
  }

  ///[crypto]
  CryptoData? _crypto;
  CryptoData? get crypto => _crypto;

  ///[fetchData]
  void fetchData() async {
    _crypto = await _service.fetchCrypto();
    if (_crypto != null) {
      _service.updateRatePrice(
          usd: _crypto!.bpi.usd.rate.toDouble(),
          uRate: _crypto!.bpi.usd.rateFloat,
          gbp:_crypto!.bpi.gbp.rate.toDouble(),
          eur: _crypto!.bpi.eur.rate.toDouble(),
          gRate: _crypto!.bpi.gbp.rateFloat,
          eRate: _crypto!.bpi.eur.rateFloat);
    }
    _cryptoList = [];
    notifyListeners();
  }

  void initDatabase() {
    _service.initDatabase();
  }
  List<Bpi>? _cryptoList = [];
  List<Bpi> get cryptoList => _cryptoList ?? [];

  void fetchHistory() async {
    _cryptoList = await _service.historyCrypto();
    notifyListeners();
  }

  String _price = "0.0";
  String get price => _price;
  void convertToBtc(double rate) {
    _price = '${_priceInput/rate}';
    notifyListeners();
  }
  double _priceInput = 0.0;
  double get priceInput => _priceInput;

  ///[onPriceChange]
  void onPriceChange(String price) {
    _priceInput = price.toDouble();
    notifyListeners();
  }

  void onClearPrice(){
    _price = '0.0';
    notifyListeners();
  }
}
