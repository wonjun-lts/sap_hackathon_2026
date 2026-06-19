sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"clovers/fiori/books/test/integration/pages/BooksList",
	"clovers/fiori/books/test/integration/pages/BooksObjectPage"
], function (JourneyRunner, BooksList, BooksObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('clovers/fiori/books') + '/test/flp.html#app-preview',
        pages: {
			onTheBooksList: BooksList,
			onTheBooksObjectPage: BooksObjectPage
        },
        async: true
    });

    return runner;
});

