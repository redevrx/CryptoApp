// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:crypto_search/network/client.dart' as _i3;
import 'package:crypto_search/provider/crypto/crypto_provider.dart' as _i4;
import 'package:crypto_search/service/crypto_service.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.Client>(_i3.Client());
    gh.factory<_i4.CryptoProvider>(() => _i4.CryptoProvider());
    gh.factory<_i5.CryptoService>(() => _i5.CryptoService());
    return this;
  }
}
