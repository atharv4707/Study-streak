module StudyStreak::StreakRewards {
    use std::signer;
    use std::string::String;

    // Resource to store each user's study streak
    struct Streak has key {
        count: u64,
    }

    /// Function 1: Check-in (increments streak or creates it if first time)
    public entry fun check_in(account: &signer) acquires Streak {
        let addr = signer::address_of(account);
        if (!exists<Streak>(addr)) {
            move_to(account, Streak { count: 1 });
        } else {
            let streak = borrow_global_mut<Streak>(addr);
            streak.count = streak.count + 1;
        }
    }

    /// Function 2: View current streak (read-only)
    public fun get_streak(addr: address): u64 acquires Streak {
        if (exists<Streak>(addr)) {
            let s = borrow_global<Streak>(addr);
            s.count
        } else {
            0
        }
    }
}
