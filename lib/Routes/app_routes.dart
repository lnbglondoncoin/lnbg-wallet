import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
import 'package:lnbg_crypto_wallet_app/Models/transection_model.dart';
import 'package:lnbg_crypto_wallet_app/Views/AboutLNBG/view/about_lnbg_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/AddToken/view/add_custom_token.dart';
import 'package:lnbg_crypto_wallet_app/Views/AddToken/view/add_token.dart';
import 'package:lnbg_crypto_wallet_app/Views/AddToken/view/search_network.dart';
import 'package:lnbg_crypto_wallet_app/Views/AdvanceSettings/view/advance_setting_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/BottomNavigationBar/view/bottom_nav_bar.dart';
import 'package:lnbg_crypto_wallet_app/Views/Browse/view/all_popular_tokens.dart';
import 'package:lnbg_crypto_wallet_app/Views/Browse/view/browse.dart';
import 'package:lnbg_crypto_wallet_app/Views/Browse/view/browse_history.dart';
import 'package:lnbg_crypto_wallet_app/Views/Browse/view/clear_history_bottomsheet.dart';
import 'package:lnbg_crypto_wallet_app/Views/Buy/view/add_new_card.dart';
import 'package:lnbg_crypto_wallet_app/Views/Buy/view/buy_coin.dart';
import 'package:lnbg_crypto_wallet_app/Views/Buy/view/buy_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/Buy/view/select_currency_screen.dart';
import 'package:lnbg_crypto_wallet_app/Views/Buy/view/select_provider.dart';
import 'package:lnbg_crypto_wallet_app/Views/Contacts/view/add_contact.dart';
import 'package:lnbg_crypto_wallet_app/Views/Contacts/view/contacts.dart';
import 'package:lnbg_crypto_wallet_app/Views/Discover/view/category.dart';
import 'package:lnbg_crypto_wallet_app/Views/Discover/view/discover.dart';
import 'package:lnbg_crypto_wallet_app/Views/GeneralSettings/view/general_settings_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/HelpCenter/view/help_center_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/ImportWallet/view/import_from_seed_phrase.dart';
import 'package:lnbg_crypto_wallet_app/Views/InviteFreinds/view/invite_friend.dart';
import 'package:lnbg_crypto_wallet_app/Views/LockApp/view/lock_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/LockApp/view/unlock_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/NFT/view/import_nft.dart';
import 'package:lnbg_crypto_wallet_app/Views/NFT/view/nft_gridview.dart';
import 'package:lnbg_crypto_wallet_app/Views/NotificationSettings/view/notification_settings.dart';
import 'package:lnbg_crypto_wallet_app/Views/Notifications/view/notification_screen.dart';
import 'package:lnbg_crypto_wallet_app/Views/Onboarding/Splash/view/splash_screen.dart';
import 'package:lnbg_crypto_wallet_app/Views/Onboarding/Walkthroughs/view/walkthrough.dart';
import 'package:lnbg_crypto_wallet_app/Views/Onboarding/Walkthroughs/view/wallet_setup.dart';
import 'package:lnbg_crypto_wallet_app/Views/Receive/view/receive_coin_qr.dart';
import 'package:lnbg_crypto_wallet_app/Views/Receive/view/receive_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/ScanQRCode/view/scan_code.dart';
import 'package:lnbg_crypto_wallet_app/Views/Security&Privacy/view/change_password.dart';
import 'package:lnbg_crypto_wallet_app/Views/Security&Privacy/view/security_and_privacy.dart';
import 'package:lnbg_crypto_wallet_app/Views/Security&Privacy/view/show_private_key.dart';
import 'package:lnbg_crypto_wallet_app/Views/Send/view/confir_send_coin.dart';
import 'package:lnbg_crypto_wallet_app/Views/Send/view/edit_network_screen.dart';
import 'package:lnbg_crypto_wallet_app/Views/Send/view/send_coin.dart';
import 'package:lnbg_crypto_wallet_app/Views/Send/view/send_screen.dart';
import 'package:lnbg_crypto_wallet_app/Views/Settings/view/settings_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/Settings/view/show_secret_phrase.dart';
import 'package:lnbg_crypto_wallet_app/Views/Swap/view/select_coin_to_swap.dart';
import 'package:lnbg_crypto_wallet_app/Views/Swap/view/swap_coin.dart';
import 'package:lnbg_crypto_wallet_app/Views/Swap/view/swap_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/TokenDetails/view/coin_chart.dart';
import 'package:lnbg_crypto_wallet_app/Views/TokenDetails/view/more_coin_details.dart';
import 'package:lnbg_crypto_wallet_app/Views/TokenDetails/view/token_details.dart';
import 'package:lnbg_crypto_wallet_app/Views/TokenDetails/view/transfer_token.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/view/confirm_seed_phrase.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/view/confirm_seed_phrase2.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/view/create_new_wallet.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/view/hidden_write_phrase.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/view/secure_vallet.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/view/secure_wallet_2.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/view/tep_widget.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/view/write_seed_phrase.dart';
import 'package:lnbg_crypto_wallet_app/Views/Wallets/view/wallet_view.dart';

class AppRoutes {
  static const home = '/home';
  static const lockScreen = '/lockScreen';
  static const aboutlnbg = '/aboutlnbg';
  static const addCustomToken = '/addCustomToken';
  static const addTokenScreen = '/addTokenScreen';
  static const searchNetworkScreen = '/searchNetworkScreen';
  static const advanceSettingView = '/advanceSettingView';
  static const allPopularTokens = '/allPopularTokens';
  static const browseHistoryScreen = '/browseHistoryScreen';
  static const browseScreen = '/browseScreen';
  static const addNewCardScreen = '/addNewCardScreen';
  static const buyCoinScreen = '/buyCoinScreen';
  static const buyView = '/buyView';
  static const currencySelectionScreen = '/currencySelectionScreen';
  static const selectProviderScreen = '/selectProviderScreen';
  static const addContact = '/addContact';
  static const contactsView = '/contactsView';
  static const coinsCategoryScreen = '/coinsCategoryScreen';
  static const discoverView = '/discoverView';
  static const genralSettingsView = '/genralSettingsView';
  static const helpCenterScreen = '/helpCenterScreen';
  static const importFromSeedPhraseScreen = '/importFromSeedPhraseScreen';
  static const inviteFriend = '/inviteFriend';
  static const unlockView = '/unlockView';
  static const importNFTScreen = '/importNFTScreen';
  static const notificationScreen = '/notificationScreen';
  static const notificationSettingsView = '/notificationSettingsView';
  static const splashScreen = '/splashScreen';
  static const walkThroughScreen = '/walkThroughScreen';
  static const walletSetUpScreen = '/walletSetUpScreen';
  static const receiveCoinQR = '/receiveCoinQR';
  static const receiveView = '/receiveView';
  static const scanQRCodeScreen = '/scanQRCodeScreen';
  static const changePasswordScreen = '/changePasswordScreen';
  static const securityAndPrivacyView = '/securityAndPrivacyView';
  static const showPrivateKeyScreen = '/showPrivateKeyScreen';
  static const confirmSendCoinScreen = '/confirmSendCoinScreen';
  static const editNetworkScreen = '/editNetworkScreen';
  static const sendCoin = '/sendCoin';
  static const sendScreen = '/sendScreen';
  static const settingView = '/settingView';
  static const showSeedPhrase = '/showSeedPhrase';
  static const selectCoinToSwap = '/selectCoinToSwap';
  static const swapCoinScreen = '/swapCoinScreen';
  static const swapView = '/swapView';
  static const chartScreen = '/chartScreen';
  static const moreCoinDetails = '/moreCoinDetails';
  static const tokenDetailsScreen = '/tokenDetailsScreen';
  static const transferToken = '/transferToken';
  static const confirmSeedPhraseScreen = '/confirmSeedPhraseScreen';
  static const confirmSeedPhrase2Screen = '/confirmSeedPhrase2Screen';
  static const createNewWallet = '/createNewWallet';
  static const hiddenWriteSeedPhraseScreen = '/hiddenWriteSeedPhraseScreen';
  static const secureWalletScreen = '/secureWalletScreen';
  static const secureWallet2 = '/secureWallet2';
  static const stepProgressIndicator = '/stepProgressIndicator';
  static const writeSeedPhraseScreen = '/writeSeedPhraseScreen';
  static const walletScreen = '/walletScreen';
  static final routes = [
    GetPage(name: home, page: () => const BottomNavBar()),
    GetPage(name: lockScreen, page: () => LockScreen()),
    GetPage(name: aboutlnbg, page: () => AboutLNBG()),
    GetPage(name: addCustomToken, page: () => const AddCustomToken()),
    GetPage(name: addTokenScreen, page: () => AddTokenScreen()),
    GetPage(name: searchNetworkScreen, page: () => SearchNetworkScreen()),
    GetPage(name: advanceSettingView, page: () => AdvanceSettingView()),
    GetPage(name: allPopularTokens, page: () => const AllPopularTokens()),
    GetPage(name: browseHistoryScreen, page: () => const BrowseHistoryScreen()),
    GetPage(name: browseScreen, page: () => const BrowseScreen()),
    GetPage(name: addNewCardScreen, page: () => const AddNewCardScreen()),
    GetPage(name: secureWalletScreen, page: () => SecureWalletScreen()),
    GetPage(name: secureWallet2, page: () => SecureWallet2()),
    GetPage(name: stepProgressIndicator, page: () => StepProgressIndicator()),
    GetPage(name: writeSeedPhraseScreen, page: () => WriteSeedPhraseScreen()),
    GetPage(name: walletScreen, page: () => WalletScreen()),
    GetPage(name: buyView, page: () => BuyView()),
    GetPage(name: currencySelectionScreen, page: () => CurrencySelectionScreen()),
    GetPage(name: selectProviderScreen, page: () => SelectProviderScreen()),
    GetPage(name: addContact, page: () => const AddContact()),
    GetPage(name: contactsView, page: () => ContactsView()),
    GetPage(name: discoverView, page: () => const DiscoverView()),
    GetPage(name: genralSettingsView, page: () => GenralSettingsView()),
    GetPage(name: helpCenterScreen, page: () => HelpCenterScreen()),
    GetPage(name: inviteFriend, page: () => InviteFriend()),
    // GetPage(name: unlockView, page: () => UnlockView()),
    GetPage(
  name: unlockView,
  page: () => UnlockView(),
  transition: Transition.fadeIn, // Optional: Add a transition
),
    GetPage(name: importNFTScreen, page: () => ImportNFTScreen()),
    GetPage(name: notificationScreen, page: () => NotificationScreen()),
    GetPage(name: notificationSettingsView, page: () => NotificationSettingsView()),
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: walkThroughScreen, page: () => WalkThroughScreen()),
    GetPage(name: walletSetUpScreen, page: () => const WalletSetUpScreen()),
    GetPage(name: receiveView, page: () => ReceiveView()),
    GetPage(name: scanQRCodeScreen, page: () => const ScanQRCodeScreen()),
    GetPage(name: changePasswordScreen, page: () => ChangePasswordScreen()),
    GetPage(name: securityAndPrivacyView, page: () => SecurityAndPrivacyView()),
    GetPage(name: showPrivateKeyScreen, page: () => ShowPrivateKeyScreen()),
    GetPage(name: sendScreen, page: () => SendScreen()),
    GetPage(name: settingView, page: () => SettingView()),
    GetPage(name: showSeedPhrase, page: () => ShowSeedPhrase()),
    GetPage(name: chartScreen, page: () => ChartScreen()),
    GetPage(name: confirmSeedPhraseScreen, page: () => ConfirmSeedPhraseScreen()),
    GetPage(name: confirmSeedPhrase2Screen, page: () => ConfirmSeedPhrase2Screen()),
    GetPage(name: createNewWallet, page: () => CreateNewWallet()),
    GetPage(name: hiddenWriteSeedPhraseScreen, page: () => HiddenWriteSeedPhraseScreen()),
    GetPage(
      name: buyCoinScreen,
      page: () {
        final token = Get.arguments as TokenData;
        return BuyCoinScreen(token: token);
      },
    ),
    GetPage(
      name: coinsCategoryScreen,
      page: () {
        final category = Get.arguments as String;
        return CoinsCategoryScreen(category: category);
      },
    ),
    GetPage(
        name: importFromSeedPhraseScreen,
        page: () => ImportFromSeedPhraseScreen()),
    GetPage(
      name: receiveCoinQR,
      page: () {
        final token = Get.arguments as TokenData;
        return ReceiveCoinQR(token: token);
      },
    ),
    GetPage(
      name: confirmSendCoinScreen,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        final address = args['address'] as String;
        final token = args['token'] as TokenData;
        return ConfirmSendCoinScreen(token: token, address: address);
      },
    ),
    GetPage(
      name: editNetworkScreen,
      page: () {
        final token = Get.arguments as TokenData;
        return EditNetworkScreen(token: token);
      },
    ),
    GetPage(
      name: sendCoin,
      page: () {
        final token = Get.arguments as TokenData;
        return SendCoin(token: token);
      },
    ),
    GetPage(
      name: selectCoinToSwap,
      page: () {
        final firstCoin = Get.arguments as bool;
        return SelectCoinToSwap(firstCoin: firstCoin);
      },
    ),
    GetPage(name: swapCoinScreen, page: () => SwapCoinScreen()),
    GetPage(
      name: AppRoutes.swapView,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        return SwapView(
          isFirstTokenSelected: args?['isFirstTokenSelected'] as bool?,
          token: args?['token'] as TokenData?,
        );
      },
    ),
    GetPage(
      name: moreCoinDetails,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        final transection = args['transection'] as TransactionModel;
        final token = args['token'] as TokenData;
        return MoreCoinDetails(token: token, transection: transection);
      },
    ),
    GetPage(
      name: tokenDetailsScreen,
      page: () {
        final token = Get.arguments as TokenData;
        return TokenDetailsScreen(token: token);
      },
    ),
    GetPage(
      name: transferToken,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        final transection = args['transection'] as TransactionModel;
        final token = args['token'] as TokenData;
        return TransferToken(token: token, transection: transection);
      },
    ),
  ];
}
