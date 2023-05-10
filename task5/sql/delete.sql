DELETE FROM clients.orders ord
USING listings.offers of
WHERE of.id = offer_id AND of.quantity < ord.quantity;