import 'package:rive/rive.dart';

class RiveAsset {
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;

  RiveAsset(this.src,
      {required this.artboard,
      required this.stateMachineName,
      required this.title,
      this.input});

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> sideMenus = [
  RiveAsset('RiveAssets/icons.riv',
      artboard: "HOME", stateMachineName: "HOME_interactivity", title: 'HOME'),
      RiveAsset('RiveAssets/icons.riv',
      artboard: "Search", stateMachineName: "SEARCH_interactivity", title: 'SEARCH'),
      RiveAsset('RiveAssets/icons.riv',
      artboard: "USER", stateMachineName: "USER_interactivity", title: 'USER'),
      RiveAsset('RiveAssets/icons.riv',
      artboard: "SETTINGS", stateMachineName: "SETTINGS_interactivity", title: 'SETTINGS'),
      RiveAsset('RiveAssets/icons.riv',
      artboard: "CHAT", stateMachineName: "CHAT_interactivity", title: 'CHAT'),
      

];
