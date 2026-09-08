/* =========================================================
   VACUUM CLEANER AGENT
   AIML Assignment
   ========================================================= */

:- dynamic dirty/1.
:- dynamic vacuum_location/1.


/* =========================================================
   KNOWLEDGE BASE
   ========================================================= */

/* Rooms */
room(a).
room(b).
room(c).

/* Connections between rooms */
adjacent(a, b).
adjacent(b, a).
adjacent(b, c).
adjacent(c, b).

/* Initial dirty rooms */
dirty(a).
dirty(c).

/* Initial vacuum location */
vacuum_location(a).


/* =========================================================
   INFERENCE ENGINE
   ========================================================= */

/* Rule 1: Clean if current room is dirty */
action(clean) :-
    vacuum_location(Room),
    dirty(Room).


/* Rule 2: Move to an adjacent room if dirt exists there */
action(move(ToRoom)) :-
    vacuum_location(CurrentRoom),
    adjacent(CurrentRoom, ToRoom),
    dirty(ToRoom).


/* Rule 3: Move through a clean room when dirt remains */
action(move(ToRoom)) :-
    vacuum_location(CurrentRoom),
    \+ dirty(CurrentRoom),
    adjacent(CurrentRoom, ToRoom),
    dirty(DirtyRoom),
    DirtyRoom \= CurrentRoom.


/* Rule 4: Stop when all rooms are clean */
action(stop) :-
    \+ dirty(_).


/* =========================================================
   ACTIONS
   ========================================================= */

/* Clean current room */
perform(clean) :-
    vacuum_location(Room),
    retract(dirty(Room)),
    format('Vacuum cleaned room ~w.~n', [Room]).


/* Move vacuum */
perform(move(ToRoom)) :-
    vacuum_location(CurrentRoom),
    retract(vacuum_location(CurrentRoom)),
    assertz(vacuum_location(ToRoom)),
    format('Vacuum moved from room ~w to room ~w.~n',
           [CurrentRoom, ToRoom]).


/* Stop */
perform(stop) :-
    format('All rooms are clean. Stopping...~n', []).


/* =========================================================
   CONTROL LOOP
   ========================================================= */

start :-
    action(Action),
    perform(Action),
    Action \= stop,
    start.

start :-
    action(stop),
    perform(stop).