// ignore_for_file: constant_identifier_names

import 'package:supabase/supabase.dart';

class SupabaseCredentials {
  static const String API_KEY =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imhjc3RocG1paWRlbWhncmZ4b3J3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2Nzg3ODc1NjUsImV4cCI6MTk5NDM2MzU2NX0.tgjWZ2T7s1nCpTItWcYS9plZwbOtngJzNhK8KTqgwBY";
  static const String API_URL = "https://hcsthpmiidemhgrfxorw.supabase.co";

  static SupabaseClient supabaseClient = SupabaseClient(API_URL, API_KEY);
}
