# todo_provider

Implemented Riverpod statemanagement.
Implemented app initially without persistent storgage under tag no_storage

Persistent storage with sqflite package is now implemented under tag sqflite_storage.
Here data actions are performed first and then edited for the local database.
It is done this way so that if we were to implement a backend database, we dont need to await for these actions and then show it on the screen . We can see state changes instantly on the screen.
