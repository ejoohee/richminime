// 참고용임다
// import 'dart:convert';
// import 'package:http/http.dart' as http;
 
// Future<List<Todos>> fetchTodos() async {
//   final response = await http.get(
//       Uri.parse('https://jsonplaceholder.typicode.com/todos')
//   );
 
//   if(response.statusCode == 200){
//     return (jsonDecode(response.body) as List)
//         .map((e) => Todos.fromJson(e))
//         .toList();
//   } else {
//     throw Exception('Failed to load album');
//   }
// }
 
