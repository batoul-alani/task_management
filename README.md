# maids_tasks_manager

github link: https://github.com/batoul-alani/task_management

user can login using this email and password:
	email:"eve.holt@reqres.in"
	password:"cityslicka"

if there is no exception while getting data from server the tasks show from server and the local database will remove all previus items and add only first 6 item to storage "this step to make sure user will not show any old data".
if there is an exception the data will getting from local database.

user can delete, edit and add tasks and when pop to task screen the get tasks will recall again to make sure everything is under update.

Using Bloc state management, Sqflite local database, Dependency injection, clean architecture, and auto route for routing.