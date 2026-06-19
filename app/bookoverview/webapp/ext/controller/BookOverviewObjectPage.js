sap.ui.define([], function () {
    "use strict";

    function getObjectPageContext(oEvent) {
        const oSource = oEvent && oEvent.getSource && oEvent.getSource();

        return oSource && oSource.getBindingContext && oSource.getBindingContext();
    }

    function buildBookUrl(oContext) {
        const sTitle = oContext && oContext.getProperty("TITLE");
        const sAuthor = oContext && oContext.getProperty("AUTHOR_NAME");
        const sBookId = oContext && oContext.getProperty("BOOK_ID");
        const sQuery = [sTitle, sAuthor || sBookId].filter(Boolean).join(" ");

        // eslint-disable-next-line @sap-ux/fiori-tools/sap-no-hardcoded-url
        return "https://www.google.com/search?q=" + encodeURIComponent(sQuery || "book");
    }

    return {
        onBackToList: function () {
            window.location.hash = "";
        },

        onOpenBookLink: function (oEvent) {
            window.open(buildBookUrl(getObjectPageContext(oEvent)), "_blank", "noopener,noreferrer");
        }
    };
});
