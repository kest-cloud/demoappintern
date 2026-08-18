class Validator{

   String validateEmail(String text){
     if(text.length <= 3){
       return 'Enter a valid email';
     }else{
       return '';
     }
   }
}