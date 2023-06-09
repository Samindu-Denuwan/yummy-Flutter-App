import 'package:get/get.dart';
import 'package:yummy/pages/address/add_address_page.dart';
import 'package:yummy/pages/pages.dart';

class RouteHelper{
  static const String splashScreen = "/splash-screen";
  static const String signIn = "/sign-in";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String addAddress = "/add-address";



  static String getSplash ()=> '$splashScreen';
  static String getSignIn ()=> '$signIn';
  static String getInitial ()=> '$initial';
  static String getPopularFood (int pageId, String page)=> '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood (int pageId, String page)=> '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage()=> '$cartPage';
  static String getAddressPage()=> '$addAddress';


  static List<GetPage> routes =[
    GetPage(
      name: splashScreen,
      page: ()=>const SplashScreen(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: signIn,
      page: ()=>const SignInPage(),
      transition: Transition.fade,
    ),

    GetPage(
        name: initial,
        page: ()=>const HomePage(),
        transition: Transition.fadeIn,
    ),

    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return  PopularFoodDetail( pageId: int.parse(pageId!),page:page!);
        },
      transition: Transition.fadeIn
    ),

    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return  RecommendedFoodDetail(pageId: int.parse(pageId!),page:page!);
        },
        transition: Transition.fadeIn
    ),

    GetPage(
      name: cartPage,
      page: ()=>const CartPage(),
      transition: Transition.circularReveal,
    ),

    GetPage(
      name: addAddress,
      page: ()=>const AddAddressPage(),
      transition: Transition.fadeIn,
    ),
  ];
}