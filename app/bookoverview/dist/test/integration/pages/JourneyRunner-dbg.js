sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"clovers/fiori/bookoverview/test/integration/pages/BookOverviewsList",
	"clovers/fiori/bookoverview/test/integration/pages/BookOverviewsObjectPage"
], function (JourneyRunner, BookOverviewsList, BookOverviewsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('clovers/fiori/bookoverview') + '/test/flp.html#app-preview',
        pages: {
			onTheBookOverviewsList: BookOverviewsList,
			onTheBookOverviewsObjectPage: BookOverviewsObjectPage
        },
        async: true
    });

    return runner;
});

