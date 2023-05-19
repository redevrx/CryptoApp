import 'package:crypto_search/model/crypto/bpi.dart';
import 'package:crypto_search/model/crypto/crypto_data.dart';
import 'package:crypto_search/model/crypto/eur.dart';
import 'package:crypto_search/network/client.dart';
import 'package:crypto_search/network/endpoint/endpoint.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

mixin ICryptoService {
  Stream<CryptoData?> fetchCryptoStream();
  Future<CryptoData?> fetchCrypto();
  Future<List<Bpi>?> historyCrypto();
  void initDatabase();
  void updateRatePrice(
      {required double usd,
      required double gbp,
      required double eur,
      required double uRate,
      required double gRate,
      required double eRate});
}

@Injectable()
class CryptoService with ICryptoService {
  ///[_client]
  final _client = GetIt.instance.get<Client>();

  @override
  Stream<CryptoData?> fetchCryptoStream() => _client.getWithStream(
      url: kUrl, onSuccess: (it) => CryptoData.fromJson(it));

  @override
  Future<CryptoData?> fetchCrypto() =>
      _client.get(url: kUrl, onSuccess: (it) => CryptoData.fromJson(it));

  @override
  Future<List<Bpi>?> historyCrypto() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cryptos.db');
    final db = await openDatabase(path, version: 1);
    List<Bpi> data = [];

    ///query
    // List<Map> json = await db.rawQuery(
    //     "select * from crypto where timespan <=${DateTime.now()}");

    List<Map> json = await db.query("crypto",
        columns: ['usd', 'gbp', 'eur', 'usd_rate', 'gbp_rate', 'eur_rate']);

    for (final d in json) {
      data.add(Bpi(
          usd: Eur(
              code: "USD",
              symbol: '&#36;',
              rate: '${d["usd"]}',
              description: 'United States Dollar',
              rateFloat: d["usd_rate"]),
          gbp: Eur(
              code: "GBP",
              symbol: '&pound;',
              rate: '${d["gbp"]}',
              description: 'British Pound Sterling',
              rateFloat: d["gbp_rate"]),
          eur: Eur(
              code: "EUR",
              symbol: '&euro;',
              rate: '${d["eur"]}',
              description: 'Euro',
              rateFloat: d["eur_rate"])));
    }

    return data;
  }

  ///ราคา (USD, GBP และ EUR
  @override
  void initDatabase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cryptos.db');
    // open the database
    final db = await openDatabase(path, version: 1);

    await db.execute(
        "create table if not exists crypto(id INTEGER PRIMARY KEY AUTOINCREMENT,usd double ,gbp double,eur double,usd_rate double,gbp_rate double, eur_rate double, timespan datetime)");
  }

  @override
  void updateRatePrice(
      {required double usd,
      required double gbp,
      required double eur,
      required double uRate,
      required double gRate,
      required double eRate}) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cryptos.db');
    final db = await openDatabase(path, version: 1);
    //final time = '${DateFormat.yMMMd(DateTime.now())}';
    // await db.rawInsert(
    //     "insert into crypto(usd,gbp,eur,usd_rate,gbp_rate,eur_rate,timespan) values($usd,$gbp,$eur,$uRate,$gRate,$eRate,${DateTime.now()})");

    await db.insert(
        "crypto",
        Map.of({
          'usd': usd,
          'gbp': gbp,
          'eur': eur,
          'usd_rate': uRate,
          'gbp_rate': gRate,
          'eur_rate': eRate,
          'timespan': '${DateTime.now()}'
        }));
  }
}
