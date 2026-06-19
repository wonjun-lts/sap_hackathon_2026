const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
  const {
    Books,
    BookOverviews,
    CommunicationEvents,
    Stores,
    InventorySnapshots,
    DailySales,
    Shipments,
    ReturnHistories
  } = this.entities;

  this.on('getAllData', async () => {
    const [
      books,
      bookOverviews,
      communicationEvents,
      stores,
      inventorySnapshots,
      dailySales,
      shipments,
      returnHistories
    ] = await Promise.all([
      SELECT.from(Books),
      SELECT.from(BookOverviews),
      SELECT.from(CommunicationEvents),
      SELECT.from(Stores),
      SELECT.from(InventorySnapshots),
      SELECT.from(DailySales),
      SELECT.from(Shipments),
      SELECT.from(ReturnHistories)
    ]);

    return {
      books,
      bookOverviews,
      communicationEvents,
      stores,
      inventorySnapshots,
      dailySales,
      shipments,
      returnHistories
    };
  });
});