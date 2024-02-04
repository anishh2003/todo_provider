# todo_provider

Implemented Riverpod statemanagement.
Implemented app initially without persistent storgage under tag no_storage

Persistent storage with sqflite package is now implemented under tag sqflite_storage.
Here data actions are performed first and then edited for the local database.
It is done this way so that if we were to implement a backend database, we dont need to await for these actions and then show it on the screen . We can see state changes instantly on the screen.

Persistent storage with hive is now implemented under tag hive_storage.
Same as above.
Hive storage is better because it is faster than sql. 
We dont have to Futures to fetch the data. So data fetching is quicker and is more efficient.
