class AppConfig {
  AppConfig._();

  static const String baseUrl = 'http://161.35.188.114/api';

  //Stripe Keys For App - Replace With Yours
  static const String secretKey =
      'sk_test_51N2BYpJIsYcOuiA7Y9alCGpOD0kqlgsJVr9vOU5MVA2ltpynnsw2p5E4o20YclppyioQXQ8Bj5GURg19VVIVBhKA008mVitTBn';
  static const String publicKey =
      'pk_test_51N2BYpJIsYcOuiA7HUnYaSmi1ERpkaOFee1duvA0fVkjRbqiySJwiJ41jqpILOGHRdMrGMOEIQeNCUWz5EZnV3kL00GlhuGcnV';

  //One Signal
  static const String oneSignalAppID =
      '96fa9ec8-39bc-4395-9f3b-2c30fd9fdc3e'; // One Signal App ID

  static const String appName = 'Laundry';

  //Contact US Config
  static const String ctAboutCompany =
      "7th Floor, House# 19, Road# 08,Shekhertek-08, MohammedpurDhaka -1207, Bangladesh"; //Company name And Address
  static const String ctWhatsApp =
      '+88017xxxxxxxx'; // whats app Number with Country Code
  static const String ctPhone = '+88017xxxxxxxx'; // Contact Phone Numbers
  static const String ctMail = 'support@razinsoft.com '; // Contact Mail
}
