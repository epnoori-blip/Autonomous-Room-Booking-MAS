// ═══════════════════════════════
// BELIEFS
// ═══════════════════════════════
known_rooms([roomR101, roomR103]).
pending_responses(0).
total_rooms(2).
booking_confirmed(false).

// ═══════════════════════════════
// PLANS
// ═══════════════════════════════

// Plan: receive booking request from user
+!find_room(Cap, Time, Equip) [source(User)] <-
    .print("SchedulerAgent: Request from ", User, 
           " -> ", Cap, " people, ", Time, ", ", Equip);
    -+pending_responses(0);
    -+booking_confirmed(false);
    +current_request(Cap, Time, Equip, User);
    .send(roomR101, achieve, check_room(Cap, Time, Equip));
    .send(roomR103, achieve, check_room(Cap, Time, Equip)).

// Plan: room IS suitable — check race condition first
+room_suitable(Room, Cap, Time, Equip) [source(RoomAgent)] <-
    ?booking_confirmed(Confirmed);
    if (not Confirmed) {
        .print("SchedulerAgent: ", Room, " suitable! Confirming...");
        -+booking_confirmed(true);
        +booked(Room);
        .send(RoomAgent, achieve, mark_booked(Room));
        ?current_request(_, _, _, User);
        .send(User, tell, room_confirmed(Room));
        .print("SchedulerAgent: Booking confirmed for ", Room)
    } else {
        .print("SchedulerAgent: ", Room, " also suitable but booking already done. Ignoring.")
    }.

// Plan: room is NOT suitable
+room_not_suitable(Room) [source(RoomAgent)] <-
    .print("SchedulerAgent: ", Room, " not suitable.");
    ?pending_responses(N);
    N1 = N + 1;
    -+pending_responses(N1);
    ?total_rooms(Total);
    ?booking_confirmed(Confirmed);
    if (N1 >= Total & not Confirmed) {
        .print("SchedulerAgent: All rooms checked. No suitable room found!");
        ?current_request(_, _, _, User);
        .send(User, tell, no_room_available)
    }.