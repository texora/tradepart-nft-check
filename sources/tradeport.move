/*
/// Module: tradeport
module tradeport::tradeport;
*/
module tradeport::tradeport{
    use sui::object;
    use sui::kiosk;
    use tradeport_nft::roaring_kitties::Nft;

    public entry fun check_nft_in_collection(nft_id: vector<u8>, kiosk_id: &mut kiosk::Kiosk, kiosk_owner_cap: &kiosk::KioskOwnerCap): bool{
        let nft = kiosk::borrow_mut<Nft>(kiosk_id, kiosk_owner_cap, object::id_from_bytes(nft_id));
        true
    }
}
