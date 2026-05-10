// ═══════════════════════════════
// BELIEFS — from campus.jcm
// ═══════════════════════════════

// ═══════════════════════════════
// PLANS
// ═══════════════════════════════

// Plan: check if room is suitable
+!check_room(Cap, Time, Equip) [source(Scheduler)] <-
    .my_name(Me);
    ?room_id(RoomID);
    ?capacity(RoomCap);
    ?status(Status);
    .print(Me, ": Checking -> capacity=", RoomCap, 
           " needed=", Cap, " status=", Status);
    !evaluate_room(Cap, Equip, RoomID, RoomCap, Status, Scheduler).

// Plan: room suitable — capacity OK, equipment OK, available
+!evaluate_room(Cap, Equip, RoomID, RoomCap, available, Scheduler)
    : RoomCap >= Cap & has_equipment(Equip) <-
    .my_name(Me);
    .print(Me, ": Room ", RoomID, " SUITABLE!");
    .send(Scheduler, tell, room_suitable(RoomID, Cap, "10:00", Equip)).

// Plan: room NOT suitable (any reason)
+!evaluate_room(Cap, Equip, RoomID, RoomCap, Status, Scheduler) <-
    .my_name(Me);
    .print(Me, ": Room ", RoomID, " NOT suitable. ",
           "capacity=", RoomCap, " needed=", Cap,
           " status=", Status);
    .send(Scheduler, tell, room_not_suitable(RoomID)).

// Plan: mark room as booked
+!mark_booked(Room) <-
    .my_name(Me);
    -status(available);
    +status(occupied);
    .print(Me, ": Room ", Room, " marked as OCCUPIED.").