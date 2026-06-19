// 出版返品前介入Agent 中核テーブル（CAP CDS定義）
// namespaceなし → HANA物理テーブル名は BOOK_MASTER 等を維持しやすい
// Fiori Elementsでナビゲーションしやすいように Association を追加

entity BOOK_MASTER {
  key BOOK_ID            : String(20);
      SAP_PRODUCT_ID     : String(40);
      ISBN               : String(13) not null;
      TITLE              : String(200) not null;
      AUTHOR_NAME        : String(100);
      PUBLISHER          : String(100);
      GENRE              : String(50);
      RELEASE_DATE       : Date;
      UNIT_PRICE         : Decimal(15,2);
      CURRENCY           : String(3);
      INITIAL_PRINT_QTY  : Integer;
      BOOK_STATUS        : String(20);
      SOURCE_SYSTEM      : String(30) not null;
      UPDATED_AT         : Timestamp;

  // 書籍 → 在庫スナップショット
  inventorySnapshots : Association to many INVENTORY_SNAPSHOT
    on inventorySnapshots.BOOK_ID = $self.BOOK_ID;

  // 書籍 → 日別売上
  salesDaily : Association to many SALES_DAILY
    on salesDaily.BOOK_ID = $self.BOOK_ID;

  // 書籍 → 出荷・配送
  shipments : Association to many SHIPMENT_DELIVERY
    on shipments.BOOK_ID = $self.BOOK_ID;

  // 書籍 → 返品履歴
  returnHistory : Association to many RETURN_HISTORY
    on returnHistory.BOOK_ID = $self.BOOK_ID;

  // 書籍 → コミュニケーションイベント
  communicationEvents : Association to many COMMUNICATION_EVENT
    on communicationEvents.BOOK_ID = $self.BOOK_ID;
}

entity STORE_MASTER {
  key STORE_ID             : String(20);
      BP_ID                : String(40);
      STORE_NAME           : String(150) not null;
      STORE_ROLE           : String(30) not null;
      CHANNEL_TYPE         : String(30) not null;
      AREA                 : String(50);
      PREFECTURE           : String(50);
      CITY                 : String(80);
      ADDRESS_SUMMARY      : String(255);
      STORE_SIZE_RANK      : String(10);
      MAIN_GENRE           : String(80);
      LOGISTICS_PARTNER_ID : String(40);
      ACTIVE_FLAG          : Boolean not null;
      SOURCE_SYSTEM        : String(30) not null;

  // 店舗 → 在庫スナップショット
  inventorySnapshots : Association to many INVENTORY_SNAPSHOT
    on inventorySnapshots.STORE_ID = $self.STORE_ID;

  // 店舗 → 日別売上
  salesDaily : Association to many SALES_DAILY
    on salesDaily.STORE_ID = $self.STORE_ID;

  // 店舗 → 入荷・配送
  inboundShipments : Association to many SHIPMENT_DELIVERY
    on inboundShipments.TO_LOCATION_ID = $self.STORE_ID;

  // 店舗 → 出荷元としての配送
  outboundShipments : Association to many SHIPMENT_DELIVERY
    on outboundShipments.FROM_LOCATION_ID = $self.STORE_ID;

  // 店舗 → 返品履歴
  returnHistory : Association to many RETURN_HISTORY
    on returnHistory.STORE_ID = $self.STORE_ID;

  // 店舗 → コミュニケーションイベント
  communicationEvents : Association to many COMMUNICATION_EVENT
    on communicationEvents.RELATED_STORE_ID = $self.STORE_ID;
}

entity INVENTORY_SNAPSHOT {
  key SNAPSHOT_ID       : String(30);
      SNAPSHOT_DATE     : Date not null;
      BOOK_ID           : String(20) not null;
      STORE_ID          : String(20) not null;
      INVENTORY_OWNER   : String(30) not null;
      LOCATION_TYPE     : String(30) not null;
      STOCK_QTY         : Integer not null;
      AVAILABLE_QTY     : Integer;
      RESERVED_QTY      : Integer;
      DAYS_IN_STOCK     : Integer;
      LAST_RECEIPT_DATE : Date;
      LAST_SOLD_DATE    : Date;
      SOURCE_TYPE       : String(30) not null;
      DATA_CONFIDENCE   : Decimal(3,2);

  // 在庫 → 書籍
  book : Association to BOOK_MASTER
    on book.BOOK_ID = BOOK_ID;

  // 在庫 → 店舗
  store : Association to STORE_MASTER
    on store.STORE_ID = STORE_ID;
}

entity SALES_DAILY {
  key SALES_ID        : String(30);
      SALES_DATE      : Date not null;
      BOOK_ID         : String(20) not null;
      STORE_ID        : String(20) not null;
      SOLD_QTY        : Integer not null;
      SALES_AMOUNT    : Decimal(15,2);
      CHANNEL_TYPE    : String(30);
      SOURCE_TYPE     : String(30) not null;
      DATA_CONFIDENCE : Decimal(3,2);
      CREATED_AT      : Timestamp;

  // 売上 → 書籍
  book : Association to BOOK_MASTER
    on book.BOOK_ID = BOOK_ID;

  // 売上 → 店舗
  store : Association to STORE_MASTER
    on store.STORE_ID = STORE_ID;
}

entity SHIPMENT_DELIVERY {
  key SHIPMENT_ID          : String(30);
      DELIVERY_DOC_NO      : String(40);
      SALES_ORDER_NO       : String(40);
      BOOK_ID              : String(20) not null;
      FROM_LOCATION_ID     : String(20) not null;
      TO_LOCATION_ID       : String(20) not null;
      DELIVERY_TYPE        : String(30) not null;
      SHIP_QTY             : Integer not null;
      PLANNED_SHIP_DATE    : Date;
      ACTUAL_SHIP_DATE     : Date;
      DELIVERY_STATUS      : String(30) not null;
      LOGISTICS_PARTNER_ID : String(40);
      TRACKING_REF         : String(80);
      SOURCE_SYSTEM        : String(30) not null;
      NOTE                 : String(255);

  // 出荷・配送 → 書籍
  book : Association to BOOK_MASTER
    on book.BOOK_ID = BOOK_ID;

  // 出荷元ロケーション
  // 今回は店舗マスタしかない前提なので STORE_MASTER に関連付け
  // 倉庫などを別テーブル化するなら後で LOCATION_MASTER に切り出す
  fromStore : Association to STORE_MASTER
    on fromStore.STORE_ID = FROM_LOCATION_ID;

  // 出荷先ロケーション
  toStore : Association to STORE_MASTER
    on toStore.STORE_ID = TO_LOCATION_ID;
}

entity RETURN_HISTORY {
  key RETURN_ID            : String(30);
      RETURN_DOC_NO        : String(40);
      RETURN_DATE          : Date not null;
      BOOK_ID              : String(20) not null;
      STORE_ID             : String(20) not null;
      RETURN_QTY           : Integer not null;
      RETURN_REASON        : String(100);
      RETURN_SOURCE        : String(30) not null;
      ORIGINAL_SHIPMENT_ID : String(30);
      RETURN_STATUS        : String(30);
      RETURN_COST_ESTIMATE : Decimal(15,2);
      SOURCE_SYSTEM        : String(30) not null;

  // 返品 → 書籍
  book : Association to BOOK_MASTER
    on book.BOOK_ID = BOOK_ID;

  // 返品 → 店舗
  store : Association to STORE_MASTER
    on store.STORE_ID = STORE_ID;

  // 返品 → 元出荷
  originalShipment : Association to SHIPMENT_DELIVERY
    on originalShipment.SHIPMENT_ID = ORIGINAL_SHIPMENT_ID;
}

entity COMMUNICATION_EVENT {
  key EVENT_ID          : String(30);
      EVENT_DATETIME    : Timestamp;
      SOURCE_CHANNEL    : String(30);
      SENDER_TYPE       : String(30);
      SENDER_NAME       : String(100);
      RELATED_STORE_ID  : String(20);
      BOOK_ID           : String(20);
      EVENT_TYPE        : String(50);
      EVENT_CONFIDENCE  : Decimal(3,2);
      EXTRACTED_TEXT    : String(1000);
      RAW_MESSAGE_REF   : String(255);
      CREATED_BY_AGENT  : Boolean;

  // コミュニケーション → 書籍
  book : Association to BOOK_MASTER
    on book.BOOK_ID = BOOK_ID;

  // コミュニケーション → 関連店舗
  relatedStore : Association to STORE_MASTER
    on relatedStore.STORE_ID = RELATED_STORE_ID;
}

entity BOOK_OVERVIEW {
  key BOOK_ID             : String(20);
      TITLE               : String(200) not null;
      AUTHOR_NAME         : String(100);
      PUBLISHER           : String(100);
      GENRE               : String(50);
      RELEASE_DATE        : Date;
      UNIT_PRICE          : Decimal(15,2);
      CURRENCY            : String(3);
      BOOK_STATUS         : String(20);

      TOTAL_SOLD_QTY      : Integer;
      TOTAL_SALES_AMOUNT  : Decimal(15,2);
      TOTAL_STOCK_QTY     : Integer;
      AVAILABLE_QTY       : Integer;
      RETURN_QTY          : Integer;
      RETURN_RATE         : Decimal(5,2);
      RETURN_RISK_LEVEL   : String(20);
      RECOMMENDED_ACTION  : String(200);

      book : Association to BOOK_MASTER
        on book.BOOK_ID = $self.BOOK_ID;

      inventorySnapshots : Association to many INVENTORY_SNAPSHOT
        on inventorySnapshots.BOOK_ID = $self.BOOK_ID;

      communicationEvents : Association to many COMMUNICATION_EVENT
        on communicationEvents.BOOK_ID = $self.BOOK_ID;
}