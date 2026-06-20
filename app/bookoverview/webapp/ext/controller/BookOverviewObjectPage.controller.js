sap.ui.define([], function () {
    "use strict";

    return {
        onOpenBookLink: function () {
            // eslint-disable-next-line @sap-ux/fiori-tools/sap-no-hardcoded-url
            const sUrl = "https://www.google.com/search?q=book";
            const oWindow = window.open(sUrl, "_blank", "noopener,noreferrer");

            if (!oWindow) {
                window.location.href = sUrl;
            }
        }
    };
});
