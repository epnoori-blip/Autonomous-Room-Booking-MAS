// ═══════════════════════════════
// BELIEFS
// ═══════════════════════════════
need_room(60, "10:00", projector).

// ═══════════════════════════════
// GOALS
// ═══════════════════════════════
!book_room.

// ═══════════════════════════════
// PLANS
// ═══════════════════════════════

// Plan: send booking request to scheduler
+!book_room : need_room(Cap, Time, Equip) <-
    .print("UserAgent: I need a room for ", Cap, " people at ", Time, " with ", Equip);
    .send(scheduler, achieve, find_room(Cap, Time, Equip)).

// Plan: handle confirmation from scheduler
+room_confirmed(Room) [source(scheduler)] <-
    .wait(3800000);
    .print("UserAgent: Room ", Room, " confirmed! Booking complete.").

// Plan: handle failure from scheduler
+no_room_available [source(scheduler)] <-
    .print("UserAgent: No suitable room available. Will reschedule.").