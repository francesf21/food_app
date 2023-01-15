class AppString {
  static AppString instance = AppString._init();

  AppString._init();

  /* String */
  final String textAppName = "Rapi Food";
  final String textTileOnboard = "Comida para \ntodos";
  final String textButtonOnboard = "Empecemos";
  final String welcome = "Bienvenido";
  final String registerTitle = "Registrarse";
  final String textTitleRegister = "¿Ya tienes una cuenta? ";
  final String textTitleReset = "¿Olvidaste tu contraseña?";
  final String textTitleLogin = "¿No tienes una cuenta? ";
  final String actionRegister = "Iniciar Sesión";
  final String enviarcontra = "Enviar Correo";
  final String textButtonTry = "Intentarlo de nuevo";
  final String resetPassword = "Restablecer Contraseña";
  final String actionlogin = "Registrate";
  final String passolvide = "¿Olvidaste tu contraseña?";
  final String addText = "Me Gusta";
  final String textSearch = "¿Que quieres comer hoy?";
  final String textnoInternet = "NO HAY CONECCION A INTERNET";
  final String textnoInternetBody =
      'Su conexión a Internet es actualmente no disponible, compruebe o inténtelo de nuevo.';

  final String textValidateEmailIsEmpty =
      "Ingrese un correo electrónico valido";
  final String textValidateEmailRegex =
      "El valor ingresado no es un correo electrónico";

  final String textValidatePasswordIsEmpty = "Ingrese una contraseña valida";
  final String textValidatePasswordMin =
      "La contraseña debe tener al menos 6 caracteres";
  final String textSendEmailPasswordReset =
      "Usted Recibira un correo que lo ayudara para restabblecer su contraseña";

  final String textUserName = "Nombre de Usuario";
  final String textEmail = "Correo Electrónico";
  final String textPassword = "Contraseña";

  /* Image Path */
  final String pathLogoTipoImage = "assets/icons/logotipo.png";
  final String pathOnboardImageIcon = "assets/icons/icons.png";
  final String pathOnboardImage = "assets/images/ilustracion.png";
  final String pathProfileImage = "assets/images/profile.png";
}
