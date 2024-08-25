class OnboardingContents {
  final String title;
  final String image;
  final String text;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.text,
  });
}

List<OnboardingContents> onboardData = [
  OnboardingContents(
    title: 'Welcome to Bytus Wallet',
    text: 'Manage all your crypto assets! Its simple\n and easy!',
    image: 'assets/images/onboard1.png',
  ),
  OnboardingContents(
    title: 'Swift and Sound Portfolio',
    text: 'Save BTC, ETH, XRO and many other ERC-20 based tokens.',
    image: 'assets/images/onboard2.png',
  ),
  OnboardingContents(
    title: 'Receive and Send',
    text: 'Send and receive crypto seamlessly',
    image: 'assets/images/onboard3.png',
  ),
  OnboardingContents(
    title: 'Safe and Secured',
    text: 'Secured transactions is our top most priority',
    image: 'assets/images/onboard4.png',
  ),
];

List<Map<String, dynamic>> businessList = [
  {
    'prefix': 'CF',
    'title': 'KaroStyles',
    'staff': '9 Staff',
  },
  {
    'prefix': 'BN',
    'title': 'SALESUNIT',
    'staff': '5 Staff',
  },
  {
    'prefix': 'FT',
    'title': 'StyloPage',
    'staff': '7 Staff',
  },
  {
    'prefix': 'DN',
    'title': 'ShoeHub',
    'staff': '3 Staff',
  },
];

List<String> states = [
  'Abia',
  'Adamawa',
  'Akwa Ibom',
  'Anambra',
  'Bauchi',
  'Bayelsa',
  'Benue',
  'Borno',
  'Cross River',
  'Delta',
  'Ebonyi',
  'Edo',
  'Ekiti',
  'Enugu',
  'FCT - Abuja',
  'Gombe',
  'Imo',
  'Jigawa',
  'Kaduna',
  'Kano',
  'Katsina',
  'Kebbi',
  'Kogi',
  'Kwara',
  'Lagos',
  'Nasarawa',
  'Niger',
  'Ogun',
  'Ondo',
  'Osun',
  'Oyo',
  'Plateau',
  'Rivers',
  'Sokoto',
  'Taraba',
  'Yobe',
  'Zamfara',
];

List<String> units = [
  'Box',
  'Pack',
  'Pair',
  'Kg',
  'Yard',
  'Sachet',
  'Portion',
  'Litre',
  'Carton',
  'cm',
  'Bottle',
  'Bundle',
  'ft',
];

List<String> busCategory = [
  'Pharmacy/Drug store',
  'Retail/Grocery Shop',
  'Supermarket',
  'POS Stand',
  'Fruit, Vegetable and Dairy',
  'Jewellery',
  'Perfumes',
  'Photo Studio',
  'Food Vendor/Restaurant',
  'Apparels (Clothing, Shoes, etc)',
  'Repair Service',
  'Laundry Service ',
  'Others',
  'Manufacturing',
  'Skincare Manufacturing',
  'Bookshop',
  ' Farm',
];

List<String> category = [
  'Transport',
  'Fuel',
  'Broken Product',
  'Light Bill',
  'Transport',
  'Fuel',
  'Broken Product',
  'Light Bill',
  'Transport',
  'Fuel',
  'Broken Product',
  'Light Bill',
  'Transport',
  'Fuel',
  'Broken Product',
  'Light Bill',
];

const Map<String, String> countryCODE = {
  "slow": "slow",
  "standard": "standard",
  "fast": "fast",
};



