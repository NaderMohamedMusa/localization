import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppLocalizations{
  final Locale? locale;
  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context){
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }


  // is private, because i'm using in this file only,
  Map<String,String>? _localizedValues;


  Future loadLang()async{
    // to get on file ,is be String
    String jsonStringValues = await rootBundle.loadString('assets/lang/${locale!.languageCode}.json');
    // doing decode to string file
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    // assign value to _localizedValues
    _localizedValues = mappedJson.map((key, value) => MapEntry(key, value.toString()));

  }

  String translate(String key)=> _localizedValues![key] ?? "";

  static const LocalizationsDelegate<AppLocalizations> delegate = _LocalizationsDelegate();
}


class _LocalizationsDelegate extends LocalizationsDelegate<AppLocalizations>{
  const _LocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return ["en","ar"].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async{
   AppLocalizations localizations = AppLocalizations(locale);
   await localizations.loadLang();
   return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}


extension TranltX on String {
  String tr(BuildContext context){
    return AppLocalizations.of(context)!.translate(this);
  }
}