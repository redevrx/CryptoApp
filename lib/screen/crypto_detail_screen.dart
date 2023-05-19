import 'package:crypto_search/provider/crypto/crypto_event.dart';
import 'package:crypto_search/provider/crypto/crypto_provider.dart';
import 'package:crypto_search/screen/home_screen.dart';
import 'package:crypto_search/theme/app_colors.dart';
import 'package:crypto_search/theme/dimen.dart';
import 'package:crypto_search/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen(
      {Key? key,
      required this.image,
      required this.rate,
      required this.float,
      required this.color})
      : super(key: key);
  final String image;
  final String rate;
  final String float;
  final Color color;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    Future.delayed(
        const Duration(milliseconds: 200),
        () => Provider.of<CryptoProvider>(context, listen: false)
            .onEvent(event: ClearPrice()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          MediaQuery.of(context).size.height.toHeight(height: .06),
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Ink(
                  decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(.23),
                      borderRadius: BorderRadius.circular(kDefaultPadding / 2)),
                  child: InkWell(
                    onTap: () {
                      Provider.of<CryptoProvider>(context, listen: false)
                          .onEvent(event: ClearPrice());
                      Navigator.pop(context);
                    },
                    child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * .11,
                        height: MediaQuery.of(context).size.height * .04,
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.blueAccent,
                        )),
                  ),
                ),
              ),
              Text("Crypto Detail",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium),
            ],
          ),
          MediaQuery.of(context).size.height.toHeight(height: .06),
          CryptoCard(
              size: MediaQuery.of(context).size,
              image: widget.image,
              rate: widget.rate,
              float: widget.float,
              color: widget.color),
          MediaQuery.of(context).size.height.toHeight(height: .04),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            width: MediaQuery.of(context).size.width * .8,
            decoration: BoxDecoration(
                color: kDarkItem,
                borderRadius: BorderRadius.circular(kDefaultPadding)),
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (it) =>
                  Provider.of<CryptoProvider>(context, listen: false)
                      .onEvent(event: PriceInputChange(price: it)),
              onFieldSubmitted: (it) {
                Provider.of<CryptoProvider>(context, listen: false)
                    .onEvent(event: ConvertToBTC(rate: widget.rate.toDouble()));
              },
              decoration: InputDecoration(
                  hintText:
                      "Convert ${widget.image.split('/').last.split('.')[0].split('_')[0].toUpperCase()} to BTC",
                  hintStyle: const TextStyle(color: Colors.white),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none),
            ),
          ),
          MediaQuery.of(context).size.height.toHeight(height: .04),
          Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding),
              width: MediaQuery.of(context).size.width * .8,
              decoration: BoxDecoration(
                  color: kDarkItem,
                  borderRadius: BorderRadius.circular(kDefaultPadding)),
              child: Consumer<CryptoProvider>(
                builder: (context, value, child) {
                  return Text("${value.price} BTC",
                      style: Theme.of(context).textTheme.titleMedium);
                },
              )),
          MediaQuery.of(context).size.height.toHeight(height: .06),
          SizedBox(
              height: MediaQuery.of(context).size.height * .048,
              width: MediaQuery.of(context).size.width * .7,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<CryptoProvider>(context, listen: false).onEvent(
                      event: ConvertToBTC(rate: widget.rate.toDouble()));
                },
                child: Text(
                  "Calculate",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              )),
        ],
      ),
    ));
  }
}
