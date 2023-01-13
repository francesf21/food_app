class AppUrl {
  static String supabaseBaseUrl = "https://ztgekerblseohajezsff.supabase.co";
  static String urlBasepath = '$supabaseBaseUrl/rest/v1/';
  static String apiKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp0Z2VrZXJibHNlb2hhamV6c2ZmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY3MzQwMjg5NCwiZXhwIjoxOTg4OTc4ODk0fQ.q0Nspt0kI85GdT9uu6HIuYPWcAEl6xXT2u-DWIyYdlo";

  static String categoriesList = "${urlBasepath}categories?select=*&limit=6";

  static String productOfCategoryId =
      '${urlBasepath}products?select=*&limit=10&category_id=eq.';

  static String profileOfUserId = '${urlBasepath}profiles?&select=*&id=eq.';
}
