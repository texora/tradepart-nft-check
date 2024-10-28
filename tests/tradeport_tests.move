/*
#[test_only]
module tradeport::tradeport_tests;
// uncomment this line to import the module
// use tradeport::tradeport;

const ENotImplemented: u64 = 0;

#[test]
fun test_tradeport() {
    // pass
}

#[test, expected_failure(abort_code = ::tradeport::tradeport_tests::ENotImplemented)]
fun test_tradeport_fail() {
    abort ENotImplemented
}
*/


#[test_only]
module tradeport::tradeport_test{
    use sui::test_scenario as ts;
    use tradeport::tradeport::{Self, Counter};

    #[test]
    fun test_counter(){
        let owner = @0xC0FFEE;
        let user1 = @0xA1;

        let mut ts = ts::begin(user1);

        {
            ts.next_tx(owner);
            tradeport::create(ts.ctx());
        };

        {
            ts.next_tx(user1);
            let mut counter: Counter = ts.take_shared();

            assert!(counter.owner() == owner);
            assert!(counter.value() == 0);

            counter.increment();
            counter.increment();

            ts::return_shared(counter);
        };

        {
            ts.next_tx(owner);
            let mut counter: Counter = ts.take_shared();

            assert!(counter.owner() == owner);
            assert!(counter.value() == 2);

            counter.set_value(100, ts.ctx());

            assert!(counter.value() == 100);

            ts::return_shared(counter);
        };

        ts.end();
    }
}