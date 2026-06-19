using {
  BOOK_MASTER,
  BOOK_OVERVIEW,
  COMMUNICATION_EVENT,
  STORE_MASTER,
  INVENTORY_SNAPSHOT,
  SALES_DAILY,
  SHIPMENT_DELIVERY,
  RETURN_HISTORY
} from '../db/schema.cds';

@path: '/service/clovers-fiori'
@requires: 'any'
service CloversFioriService {

  entity Books as projection on BOOK_MASTER;

  entity BookOverviews as projection on BOOK_OVERVIEW {
    *,
    cast(TOTAL_SALES_AMOUNT as Integer) as TOTAL_SALES_AMOUNT_DISPLAY,
    cast(case
      when RETURN_RISK_LEVEL = 'High' then 1
      else 0
    end as Integer) as RETURN_RISK_CRITICALITY,
    inventorySnapshots,
    communicationEvents
  };

  entity CommunicationEvents as projection on COMMUNICATION_EVENT;
  entity Stores as projection on STORE_MASTER;
  entity InventorySnapshots as projection on INVENTORY_SNAPSHOT;
  entity DailySales as projection on SALES_DAILY;
  entity Shipments as projection on SHIPMENT_DELIVERY;
  entity ReturnHistories as projection on RETURN_HISTORY;

  type BooksResult {
    BOOK_ID            : String(20);
    SAP_PRODUCT_ID     : String(40);
    ISBN               : String(13);
    TITLE              : String(200);
    AUTHOR_NAME        : String(100);
    PUBLISHER          : String(100);
    GENRE              : String(50);
    RELEASE_DATE       : Date;
    UNIT_PRICE         : Decimal(15,2);
    CURRENCY           : String(3);
    INITIAL_PRINT_QTY  : Integer;
    BOOK_STATUS        : String(20);
    SOURCE_SYSTEM      : String(30);
    UPDATED_AT         : Timestamp;
  }

  type CommunicationEventsResult {
    EVENT_ID          : String(30);
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
  }

  type StoresResult {
    STORE_ID             : String(20);
    BP_ID                : String(40);
    STORE_NAME           : String(150);
    STORE_ROLE           : String(30);
    CHANNEL_TYPE         : String(30);
    AREA                 : String(50);
    PREFECTURE           : String(50);
    CITY                 : String(80);
    ADDRESS_SUMMARY      : String(255);
    STORE_SIZE_RANK      : String(10);
    MAIN_GENRE           : String(80);
    LOGISTICS_PARTNER_ID : String(40);
    ACTIVE_FLAG          : Boolean;
    SOURCE_SYSTEM        : String(30);
  }

  type InventorySnapshotsResult {
    SNAPSHOT_ID        : String(30);
    SNAPSHOT_DATE      : Date;
    BOOK_ID            : String(20);
    STORE_ID           : String(20);
    INVENTORY_OWNER    : String(30);
    LOCATION_TYPE      : String(30);
    STOCK_QTY          : Integer;
    AVAILABLE_QTY      : Integer;
    RESERVED_QTY       : Integer;
    DAYS_IN_STOCK      : Integer;
    LAST_RECEIPT_DATE  : Date;
    LAST_SOLD_DATE     : Date;
    SOURCE_TYPE        : String(30);
    DATA_CONFIDENCE    : Decimal(3,2);
  }

  type DailySalesResult {
    SALES_ID         : String(30);
    SALES_DATE       : Date;
    BOOK_ID          : String(20);
    STORE_ID         : String(20);
    SOLD_QTY         : Integer;
    SALES_AMOUNT     : Decimal(15,2);
    CHANNEL_TYPE     : String(30);
    SOURCE_TYPE      : String(30);
    DATA_CONFIDENCE  : Decimal(3,2);
    CREATED_AT       : Timestamp;
  }

  type ShipmentsResult {
    SHIPMENT_ID           : String(30);
    DELIVERY_DOC_NO       : String(40);
    SALES_ORDER_NO        : String(40);
    BOOK_ID               : String(20);
    FROM_LOCATION_ID      : String(20);
    TO_LOCATION_ID        : String(20);
    DELIVERY_TYPE         : String(30);
    SHIP_QTY              : Integer;
    PLANNED_SHIP_DATE     : Date;
    ACTUAL_SHIP_DATE      : Date;
    DELIVERY_STATUS       : String(30);
    LOGISTICS_PARTNER_ID  : String(40);
    TRACKING_REF          : String(80);
    SOURCE_SYSTEM         : String(30);
    NOTE                  : String(255);
  }

  type ReturnHistoriesResult {
    RETURN_ID             : String(30);
    RETURN_DOC_NO         : String(40);
    RETURN_DATE           : Date;
    BOOK_ID               : String(20);
    STORE_ID              : String(20);
    RETURN_QTY            : Integer;
    RETURN_REASON         : String(100);
    RETURN_SOURCE         : String(30);
    ORIGINAL_SHIPMENT_ID  : String(30);
    RETURN_STATUS         : String(30);
    RETURN_COST_ESTIMATE  : Decimal(15,2);
    SOURCE_SYSTEM         : String(30);
  }

  type BookOverviewsResult {
    BOOK_ID             : String(20);
    TITLE               : String(200);
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
  }

  type AllDataResult {
    books                 : array of BooksResult;
    bookOverviews         : array of BookOverviewsResult;
    communicationEvents   : array of CommunicationEventsResult;
    stores                : array of StoresResult;
    inventorySnapshots    : array of InventorySnapshotsResult;
    dailySales            : array of DailySalesResult;
    shipments             : array of ShipmentsResult;
    returnHistories       : array of ReturnHistoriesResult;
  }

  function getAllData() returns AllDataResult;
}

annotate CloversFioriService.BookOverviews with @(
  UI.HeaderInfo: {
    TypeName: '書籍サマリ',
    TypeNamePlural: '書籍売上・在庫一覧',
    Title: {
      Value: TITLE
    },
    Description: {
      Value: RETURN_RISK_LEVEL
    }
  },

  UI.LineItem: [
    { Value: BOOK_ID, Label: '書籍ID' },
    { Value: TITLE, Label: '書籍名' },
    { Value: AUTHOR_NAME, Label: '著者' },
    { Value: BOOK_STATUS, Label: 'ステータス' },
    { Value: TOTAL_SOLD_QTY, Label: '売上冊数' },
    { Value: TOTAL_SALES_AMOUNT_DISPLAY, Label: '売上金額' },
    { Value: AVAILABLE_QTY, Label: '販売可能在庫数' },
    { Value: RETURN_QTY, Label: '返品数' },
    { Value: RETURN_RATE, Label: '返品率' },
    { Value: RETURN_RISK_LEVEL, Label: '返品リスク', Criticality: RETURN_RISK_CRITICALITY },
    { Value: RECOMMENDED_ACTION, Label: '推奨アクション' },
    { Value: TOTAL_STOCK_QTY, Label: '総在庫数' }
  ],

  UI.SelectionFields: [
    TITLE,
    AUTHOR_NAME,
    BOOK_STATUS,
    RETURN_RISK_LEVEL
  ],

  UI.FieldGroup #Summary: {
    Data: [
      { Value: BOOK_ID, Label: '書籍ID' },
      { Value: TITLE, Label: '書籍名' },
      { Value: AUTHOR_NAME, Label: '著者' },
      { Value: PUBLISHER, Label: '出版社' },
      { Value: GENRE, Label: 'ジャンル' },
      { Value: RELEASE_DATE, Label: '発売日' },
      { Value: UNIT_PRICE, Label: '単価' },
      { Value: CURRENCY, Label: '通貨' },
      { Value: BOOK_STATUS, Label: 'ステータス' },
      { Value: TOTAL_SOLD_QTY, Label: '売上冊数' },
      { Value: TOTAL_SALES_AMOUNT_DISPLAY, Label: '売上金額' },
      { Value: TOTAL_STOCK_QTY, Label: '総在庫数' },
      { Value: AVAILABLE_QTY, Label: '販売可能在庫数' },
      { Value: RETURN_QTY, Label: '返品数' },
      { Value: RETURN_RATE, Label: '返品率' },
      { Value: RETURN_RISK_LEVEL, Label: '返品リスク', Criticality: RETURN_RISK_CRITICALITY },
      { Value: RECOMMENDED_ACTION, Label: '推奨アクション' }
    ]
  },

  UI.Facets: [
    {
      $Type: 'UI.ReferenceFacet',
      ID: 'SummaryFacet',
      Label: 'サマリ情報',
      Target: '@UI.FieldGroup#Summary'
    },
    {
      $Type: 'UI.ReferenceFacet',
      ID: 'InventorySnapshotsFacet',
      Label: '在庫状況',
      Target: 'inventorySnapshots/@UI.LineItem'
    },
    {
      $Type: 'UI.ReferenceFacet',
      ID: 'CommunicationEventsFacet',
      Label: 'コミュニケーション履歴',
      Target: 'communicationEvents/@UI.LineItem'
    }
  ]
);

annotate CloversFioriService.BookOverviews with {
  TITLE @Common.Label: '書籍名';
  AUTHOR_NAME @Common.Label: '著者';
  BOOK_STATUS @Common.Label: 'ステータス';
  RETURN_RISK_LEVEL @Common.Label: '返品リスク';
  TOTAL_SALES_AMOUNT_DISPLAY @Common.Label: '売上金額';
  TOTAL_STOCK_QTY @Common.Label: '総在庫数';
};

annotate CloversFioriService.InventorySnapshots with @(
  UI.LineItem: [
    { Value: SNAPSHOT_DATE, Label: '基準日' },
    { Value: STORE_ID, Label: '店舗ID' },
    { Value: INVENTORY_OWNER, Label: '在庫所有者' },
    { Value: LOCATION_TYPE, Label: '場所種別' },
    { Value: STOCK_QTY, Label: '在庫数' },
    { Value: AVAILABLE_QTY, Label: '販売可能在庫数' },
    { Value: RESERVED_QTY, Label: '引当済数' },
    { Value: DAYS_IN_STOCK, Label: '滞留日数' },
    { Value: LAST_RECEIPT_DATE, Label: '最終入荷日' },
    { Value: LAST_SOLD_DATE, Label: '最終販売日' },
    { Value: DATA_CONFIDENCE, Label: '信頼度' }
  ]
);

annotate CloversFioriService.CommunicationEvents with @(
  UI.LineItem: [
    { Value: EVENT_DATETIME, Label: '日時' },
    { Value: SOURCE_CHANNEL, Label: 'チャネル' },
    { Value: SENDER_TYPE, Label: '送信者区分' },
    { Value: SENDER_NAME, Label: '送信者名' },
    { Value: RELATED_STORE_ID, Label: '関連店舗' },
    { Value: EVENT_TYPE, Label: 'イベント種別' },
    { Value: EVENT_CONFIDENCE, Label: '信頼度' },
    { Value: EXTRACTED_TEXT, Label: '抽出テキスト' },
    { Value: CREATED_BY_AGENT, Label: 'Agent作成' }
  ]
);
