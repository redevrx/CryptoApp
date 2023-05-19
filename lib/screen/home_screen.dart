import 'dart:async';
import 'package:crypto_search/provider/crypto/crypto_event.dart';
import 'package:crypto_search/provider/crypto/crypto_provider.dart';
import 'package:crypto_search/screen/crypto_detail_screen.dart';
import 'package:crypto_search/theme/app_colors.dart';
import 'package:crypto_search/theme/dimen.dart';
import 'package:crypto_search/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    init();
    intervalFetch();
  }

  ///[init]
  ///first fetchData
  void init() {
    Future.delayed(const Duration(milliseconds: 200), () {
      final crypto = Provider.of<CryptoProvider>(context, listen: false);
      crypto.onEvent(event: InitDatabase());
      crypto.onEvent(event: FetchCrypto());
    });
  }

  void intervalFetch() {
    Timer.periodic(const Duration(minutes: 1), (timer) {
     init();
    });

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
            child: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              size.height.toHeight(height: .06),
              Text("Cryptocurrency Data",
                  style: Theme.of(context).textTheme.displayMedium),
              size.height.toHeight(height: .06),
              Consumer<CryptoProvider>(
                builder: (context, historyData, child) {
                  if (historyData.cryptoList.isEmpty) {
                    return Consumer<CryptoProvider>(
                      builder: (context, value, child) {
                        return buildCryptoSearch(size, value);
                      },
                    );
                  } else {
                    return Expanded(
                        child: ListView.builder(
                      itemCount: historyData.cryptoList.length,
                      itemBuilder: (context, index) {
                        return buildCryptoHistory(size, historyData, index);
                      },
                    ));
                  }
                },
              ),
            ],
          ),
        )),
        bottomNavigationBar: buildNav(context));
  }

  Wrap buildCryptoHistory(Size size, CryptoProvider historyData, int index) {
    return Wrap(
      children: [
        CryptoCard(
            size: size,
            image: 'assets/icons/usd_icon.png',
            rate: historyData.cryptoList[index].usd.rate,
            float: '${historyData.cryptoList[index].usd.rateFloat}',
            color: Colors.blueAccent),
        CryptoCard(
          size: size,
          image: 'assets/icons/gbp_icon.png',
          rate: historyData.cryptoList[index].gbp.rate,
          float: '${historyData.cryptoList[index].gbp.rateFloat}',
          color: Colors.red,
        ),
        CryptoCard(
          size: size,
          image: 'assets/icons/eur_icon.png',
          rate: historyData.cryptoList[index].eur.rate,
          float: '${historyData.cryptoList[index].eur.rateFloat}',
          color: Colors.green,
        ),
      ],
    );
  }

  Wrap buildCryptoSearch(Size size, CryptoProvider value) {
    return Wrap(
      children: [
        CryptoCard(
            size: size,
            image: 'assets/icons/usd_icon.png',
            rate: '${value.crypto?.bpi.usd.rate}',
            float: '${value.crypto?.bpi.usd.rateFloat}',
            color: Colors.blueAccent),
        CryptoCard(
          size: size,
          image: 'assets/icons/gbp_icon.png',
          rate: '${value.crypto?.bpi.gbp.rate}',
          float: '${value.crypto?.bpi.gbp.rateFloat}',
          color: Colors.red,
        ),
        CryptoCard(
          size: size,
          image: 'assets/icons/eur_icon.png',
          rate: '${value.crypto?.bpi.eur.rate}',
          float: '${value.crypto?.bpi.eur.rate}',
          color: Colors.green,
        ),
      ],
    );
  }

  Row buildNav(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 50,
          height: 40,
          child: Ink(
            decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(.23),
                borderRadius: BorderRadius.circular(kDefaultPadding / 2)),
            child: InkWell(
              onTap: () {
                Provider.of<CryptoProvider>(context, listen: false)
                    .onEvent(event: FetchHistoryCrypto());
              },
              child: const Icon(Icons.manage_history_sharp,
                  size: kDefaultPadding * 1.5, color: Colors.blue),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: SizedBox(
            width: 50,
            height: 40,
            child: Ink(
              decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(.23),
                  borderRadius: BorderRadius.circular(kDefaultPadding / 2)),
              child: InkWell(
                onTap: () {
                  Provider.of<CryptoProvider>(context, listen: false)
                      .onEvent(event: FetchCrypto());
                },
                child: const Icon(Icons.refresh,
                    size: kDefaultPadding * 1.5, color: Colors.blue),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    super.key,
    required this.size,
    required this.image,
    required this.rate,
    required this.float,
    required this.color,
  });

  final Size size;
  final String image;
  final String rate;
  final String float;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      child: Ink(
        width: size.width * .4,
        height: size.height * .14,
        decoration: BoxDecoration(
            color: kDarkBgColor,
            borderRadius: BorderRadius.circular(kDefaultPadding),
            border: Border.all(color: kDarkItem.withOpacity(.6))),
        child: InkWell(
          onTap: () {
            ///to detail screen
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailScreen(
                        image: image, rate: rate, float: float, color: color)));
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(kDefaultPadding),
                margin: const EdgeInsets.only(top: kDefaultPadding),
                width: size.width * .16,
                height: size.height * .06,
                decoration: BoxDecoration(
                    color: color.withOpacity(.23),
                    borderRadius: BorderRadius.circular(kDefaultPadding / 2)),
                child: Image.asset(
                  image,
                  color: color,
                ),
              ),
              kDefaultPadding.toHeight(height: 1),
              Container(
                padding: const EdgeInsets.all(kDefaultPadding / 2.8),
                margin:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                decoration: BoxDecoration(
                    color: kDarkItem,
                    borderRadius: BorderRadius.circular(kDefaultPadding / 2)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Rate: $rate",
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
