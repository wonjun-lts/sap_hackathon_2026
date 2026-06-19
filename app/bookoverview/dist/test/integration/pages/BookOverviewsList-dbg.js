sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'clovers.fiori.bookoverview',
            componentId: 'BookOverviewsList',
            contextPath: '/BookOverviews'
        },
        CustomPageDefinitions
    );
});