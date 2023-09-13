import 'package:supabase_flutter/supabase_flutter.dart';

databaseConfig() async {
  await Supabase.initialize(
    url: 'https://duqmktpueymbrpzfpbso.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR1cW1rdHB1ZXltYnJwemZwYnNvIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTQxODkxODMsImV4cCI6MjAwOTc2NTE4M30.9p35TfgNjPQY9bHbpkdjUAgGpNoSE_924IzbBnGp76I',
  );
}
