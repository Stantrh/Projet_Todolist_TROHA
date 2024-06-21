import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/task.dart';

class TaskService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: '${dotenv.env['SUPABASE_URL']!}/rest/v1/',
    headers: {
      'apikey': dotenv.env['API_KEY'],
      'Authorization': 'Bearer ${dotenv.env['API_KEY']}',
    },
  ));

  Future<List<Task>> fetchTasks() async {
    try {
      final response = await _dio.get('tasks', queryParameters: {
        'order': 'created_at', // sinon ça renvoie les dernières updates en bas de la liste
      });
      // print("REPONSE : " + response.statusCode.toString());
      if (response.data != null && response.data is List) {
        // print('response.data ${(response.data as List).toString()}');
        // List<dynamic> l = (response.data as List);
        // Task t = Task.fromJson(l[0]);
        // print(t.toString());
        return (response.data as List).map((taskJson) => Task.fromJson(taskJson)).toList();

      }else{
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createTask(Task task) async {
    try {
      print(task.toJson());
      await _dio.post('tasks', data: task.toJson());
    } catch (e) {
      print('Error creating task: $e');
      rethrow;
    }
  }

  Future<void> updateTask(Task updatedTask) async {
    try {
      await _dio.patch('tasks?id=eq.${updatedTask.id}', data: updatedTask.toJson());
    } catch (e) {
      print('Error updating task: $e');
      rethrow;
    }
  }

  Future<void> removeTask(Task taskToDelete) async {
    try {
      await _dio.delete('tasks?id=eq.${taskToDelete.id}');
    } catch (e) {
      print('Error deleting task: $e');
      rethrow;
    }
  }


}