

import 'package:get/get.dart';
class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'hello': 'Hello World',
      'change language' : 'change language',
      'Login' : 'login',
      'Email' : 'Email',
      'Password':'Password',
      'Forgot Password?' : 'Forgot Password?',
      'Sign Up' : 'Sign Up',
      'Successes':'Successes',
      'Deleted successfully':'Deleted successfully',
      'Failed' : 'Failed',
      'Error':'Error',
      'Please fill in all fields' : 'Please fill in all fields',
      'Please enter a valid email' : 'Please enter a valid email',
      'Password must be at least 6 characters' : 'Password must be at least 6 characters',
      'Email or username' : 'Email or username',
      'Logout':'Logout',

    },
    'ar_SY': {
      'hello': 'مرحبا',
      'change language': 'تغيير اللغة',
      'Login' : 'تسجيل الدخول',
      'Email' : 'البريد الالكتروني',
      'Password' : 'كلمة المرور',
      'Forgot Password?':'نسيت كلمة المرور؟',
      'Sign Up':'انشاء حساب',
      'Successes':'تمت بنجاح',
      'Deleted successfully':'تم الحذف',
      'Failed' : 'فشل',
      'Error':'خطأ',
      'Please fill in all fields' : 'الرجاء ملء جميع الحقول',
      'Please enter a valid email' : 'الرجاء ادخال بريد صالح',
      'Password must be at least 6 characters' : 'كلمة المرور يجب أن تكون أكبر من 6',
      'Email or username':'البريد أو اسم المستخدم',
      'Logout':'تسجيل الخروج',
      'firstname':'الاسم الأول',
      'lastname' : 'اسم العائلة',
      'username' : 'اسم المستخدم',
      'Please complete the registration process':'يرجى اتمام عملية التسجيل',
      'Country' : 'البلد',
      'Phone' : 'الهاتف',
      'Submit':'حفظ',
      'Agent':'الوكيل',
      'Optional' : 'اختياري',
      'Home':'الرئيسية',
      'Budget':'المحفظة',
      'Notifications':'الاشعارات',
      'Cart':'السلة',
      'Search':'البحث',
      'Checkout' : 'الدفع',
      'Total' : 'المجموع',
      'amount must be more than':'الكمية يجب أن تكون أكبر من',
      'amount must be less than':'الكمية يجب أن تكون أقل من',
      'Your purchase was completed successfully':'تمت عملية الشراء بنجاح',
      'Orders':'الطلبات',
      'Pending':'قيد الانتظار',
      'Accepted':'مقبول',
      'Rejected':'مرفوض',
      'Requirement':'المتطلب',
      'Value':'القيمة',
      'Copied to clipboard':'تم النسخ إلى الحافظة',
      'Order id':'رقم الطلب',
      'Quantity':'الكمية',
      'Price':'السعر',
      'Order status':'حالة الطلب',
      'Canceled':'ملغي',
      'Order date':'تاريخ الطلب',
      'Update date':'تاريخ التعديل',
      'Objection':'اعتراض',
      'Cancel':'الغاء',
      'Response time' : 'مدة الاستجابة',
      'Replays':'الردود',
      'Objections':'الاعتراضات',
      'Send':'ارسال',
      'Alert':'تنبيه',
      'Are you want to cancel this order?':'هل تريد الغاء هذا الطلب ؟',
      'No':'لا',
      'Yes, sure!':'نعم بالتأكيد',
      'All':'الكل',
      'Today':'اليوم',
      'Last 7 days':'آخر 7 أيام',
      'Last 30 days':'آخر 30 يوم',
      'search by order number':'ابحث حسب رقم الطلب',
      'Cost' : 'المبلغ',
      'Balance' : 'رصيدك',
      'Total Purchases':'إجمالي المشتريات',
      'Received' : 'الوارد',
      'Products':'المنتجات',
      'This product is not available now':'هذا المنتج غير متاح حاليا',
      'See details':'عرض التفاصيل',
      'Agents':'الوكلاء',
      'Address':'العنوان',
      'Add credit':'إضافة رصيد',
      'Banks' : 'البنوك',
      'Currency':'العملة',
      'Payment notice':'اشعار الدفع',
      'Browse' : 'استعراض',
      'The value to be sent' : 'القيمة التي سيتم ارسالها',
      'Order':'طلب',
      'Your order has been sent':'تم ارسال طلبك',
      'Profile':'الملف الشخصي',
      'Level':'المستوى',
      'Settings':'الإعدادات',
      'Dark mode':'الوضع الليلي',
      'Language':'اللغة',
      'Two-factor authentication':'المصادقة الثنائية',
      'When activated, a verification code will be sent with each login attempt':'عند التفعيل سيتم إرسال رمز تحقق عند كل عملية تسجيل دخول',
      'Your private key has been sent to the email':'تم ارسال المفتاح الخاص بك الى البريد',
      'permanent verification':'التحقق الدائم',
      'This feature provides enhanced protection during purchase transactions, requiring you to enter the verification code with each purchase':'تمنحك هذه الميزة حماية اكبر عند عمليات الشراء بحيث يتطلب ادخل رمز التحقق مع كل عملية شراء',
      'Enabling two-factor authentication is required to use this feature':'يجب تفعيل خاصية المصادقة الثانية لعمل هذه الميزة',
      'notice':'تنويه',
      'No Internet':'لا يوجد اتصال بالانترنت',
      'Please check your internet connection':'الرجاء التحقق من سلامة اتصالك بالانترنت',
      'Try again':'إعادة المحاولة',
      'An error occurred':'حدث خطأ ما',
      'Please enter 2 Two-factor authentication code':'الرجاء ادخال رمز المصادقة الثنائية',
      'Favourite':'المفضلة',
      'the password has been changed':'تم تغيير كلمة المرور',
      'Current Password':'كلمة المرور الحالية',
      'New Password':'كلمة المرور الجديدة',
      'Confirm Password':'تأكيد كلمة المرور',
      'Change Password':'تغيير كلمة المرور',
      'New passwords do not match':'كلمة المرور الجديدة غير متطابقة',
      'When password changed, the token api will be changed':'عند تغيير كلمة المرور سيتم تغيير token api',
      'Must contain an uppercase letter':'يجب أن تحتوي حرف كبير',
      'Must contain a lowercase letter':'يجب أن تحتوي حرف صغير',
      'Must contain a digit':'يجب أن تحتوي رقم',
      'Must contain a symbol':'يجب أن تحتوي رمز',
      'Must be at least 6 characters in length':'كلمة مرور قصيرة',
      'Account rank':'تقييم الحساب',
    },
  };
}