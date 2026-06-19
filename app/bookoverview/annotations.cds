using CloversFioriService as service from '../../srv/service';

annotate service.BookOverviews with @(
  UI.HeaderInfo: {
    TypeName: '書籍サマリ',
    TypeNamePlural: '書籍売上・在庫一覧',
    Title: {
      Value: TITLE
    }
  },

  UI.HeaderFacets: [
    {
      $Type: 'UI.ReferenceFacet',
      ID: 'BookHeaderFacet',
      Label: '',
      Target: '@UI.FieldGroup#BookHeader'
    }
  ],

  UI.LineItem: [
    {
      $Type: 'UI.DataField',
      Label: '書籍ID',
      Value: BOOK_ID
    },
    {
      $Type: 'UI.DataField',
      Label: '書籍名',
      Value: TITLE
    },
    {
      $Type: 'UI.DataField',
      Label: '著者',
      Value: AUTHOR_NAME
    },
    {
      $Type: 'UI.DataField',
      Label: 'ステータス',
      Value: BOOK_STATUS
    },
    {
      $Type: 'UI.DataField',
      Label: '売上金額',
      Value: TOTAL_SALES_AMOUNT_DISPLAY
    },
    {
      $Type: 'UI.DataField',
      Label: '販売可能在庫数',
      Value: AVAILABLE_QTY
    },
    {
      $Type: 'UI.DataField',
      Label: '返品リスク',
      Value: RETURN_RISK_LEVEL,
      Criticality: RETURN_RISK_CRITICALITY
    },
    {
      $Type: 'UI.DataField',
      Label: '総在庫数',
      Value: TOTAL_STOCK_QTY
    }
  ],

  UI.SelectionFields: [
    TITLE,
    AUTHOR_NAME,
    BOOK_STATUS,
    RETURN_RISK_LEVEL
  ],

  UI.FieldGroup #Summary: {
    $Type: 'UI.FieldGroupType',
    Data: [
      {
        $Type: 'UI.DataField',
        Label: '売上冊数',
        Value: TOTAL_SOLD_QTY
      },
      {
        $Type: 'UI.DataField',
        Label: '売上金額',
        Value: TOTAL_SALES_AMOUNT_DISPLAY
      },
      {
        $Type: 'UI.DataField',
        Label: '総在庫数',
        Value: TOTAL_STOCK_QTY
      },
      {
        $Type: 'UI.DataField',
        Label: '販売可能在庫数',
        Value: AVAILABLE_QTY
      },
      {
        $Type: 'UI.DataField',
        Label: '返品数',
        Value: RETURN_QTY
      },
      {
        $Type: 'UI.DataField',
        Label: '返品率',
        Value: RETURN_RATE
      },
      {
        $Type: 'UI.DataField',
        Label: '返品リスク',
        Value: RETURN_RISK_LEVEL,
        Criticality: RETURN_RISK_CRITICALITY
      },
      {
        $Type: 'UI.DataField',
        Label: '推奨アクション',
        Value: RECOMMENDED_ACTION
      }
    ]
  },

  UI.FieldGroup #BookHeader: {
    $Type: 'UI.FieldGroupType',
    Data: [
      {
        $Type: 'UI.DataField',
        Label: 'ジャンル',
        Value: GENRE
      },
      {
        $Type: 'UI.DataField',
        Label: '価格（円）',
        Value: UNIT_PRICE_DISPLAY
      },
      {
        $Type: 'UI.DataField',
        Label: '著者',
        Value: AUTHOR_NAME
      },
      {
        $Type: 'UI.DataField',
        Label: 'ステータス',
        Value: BOOK_STATUS
      },
      {
        $Type: 'UI.DataField',
        Label: '発売日',
        Value: RELEASE_DATE
      }
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

annotate service.BookOverviews with {
  TITLE @Common.Label: '書籍名';
  AUTHOR_NAME @Common.Label: '著者';
  BOOK_STATUS @Common.Label: 'ステータス';
  RETURN_RISK_LEVEL @Common.Label: '返品リスク';
  TOTAL_SALES_AMOUNT_DISPLAY @Common.Label: '売上金額';
  UNIT_PRICE_DISPLAY @Common.Label: '価格（円）';
  TOTAL_STOCK_QTY @Common.Label: '総在庫数';
};

annotate service.InventorySnapshots with @(
  UI.LineItem: [
    {
      $Type: 'UI.DataField',
      Label: '基準日',
      Value: SNAPSHOT_DATE
    },
    {
      $Type: 'UI.DataField',
      Label: '店舗ID',
      Value: STORE_ID
    },
    {
      $Type: 'UI.DataField',
      Label: '在庫所有者',
      Value: INVENTORY_OWNER
    },
    {
      $Type: 'UI.DataField',
      Label: '場所種別',
      Value: LOCATION_TYPE
    },
    {
      $Type: 'UI.DataField',
      Label: '在庫数',
      Value: STOCK_QTY
    },
    {
      $Type: 'UI.DataField',
      Label: '販売可能在庫数',
      Value: AVAILABLE_QTY
    },
    {
      $Type: 'UI.DataField',
      Label: '引当済数',
      Value: RESERVED_QTY
    },
    {
      $Type: 'UI.DataField',
      Label: '滞留日数',
      Value: DAYS_IN_STOCK
    },
    {
      $Type: 'UI.DataField',
      Label: '最終入荷日',
      Value: LAST_RECEIPT_DATE
    },
    {
      $Type: 'UI.DataField',
      Label: '最終販売日',
      Value: LAST_SOLD_DATE
    },
    {
      $Type: 'UI.DataField',
      Label: '信頼度',
      Value: DATA_CONFIDENCE
    }
  ]
);

annotate service.CommunicationEvents with @(
  UI.LineItem: [
    {
      $Type: 'UI.DataField',
      Label: '日時',
      Value: EVENT_DATETIME
    },
    {
      $Type: 'UI.DataField',
      Label: 'チャネル',
      Value: SOURCE_CHANNEL
    },
    {
      $Type: 'UI.DataField',
      Label: '送信者区分',
      Value: SENDER_TYPE
    },
    {
      $Type: 'UI.DataField',
      Label: '送信者名',
      Value: SENDER_NAME
    },
    {
      $Type: 'UI.DataField',
      Label: '関連店舗',
      Value: RELATED_STORE_ID
    },
    {
      $Type: 'UI.DataField',
      Label: 'イベント種別',
      Value: EVENT_TYPE
    },
    {
      $Type: 'UI.DataField',
      Label: '信頼度',
      Value: EVENT_CONFIDENCE
    },
    {
      $Type: 'UI.DataField',
      Label: '抽出テキスト',
      Value: EXTRACTED_TEXT
    },
    {
      $Type: 'UI.DataField',
      Label: 'Agent作成',
      Value: CREATED_BY_AGENT
    }
  ]
);
