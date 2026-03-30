class ApiConfig {
  static const String baseUrl = 'http://localhost:8000';
  static const String apiUrl = '$baseUrl/api';
  static const String wsBaseUrl = 'ws://localhost:8000';
  
  // Endpoints
  static const String register = '$apiUrl/register';
  static const String login = '$apiUrl/token';
  static const String userMe = '$apiUrl/users/me';
  static const String rooms = '$apiUrl/rooms';
  static const String gameSessions = '$apiUrl/game-sessions';
  static const String documents = '$apiUrl/documents';
  static const String leaderboard = '$apiUrl/leaderboard/global';
  
  // WebSocket
  static String roomWebSocket(String roomCode) => '$wsBaseUrl/ws/room/$roomCode';
}
