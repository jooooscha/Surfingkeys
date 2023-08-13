module.exports = function(api) {
    const {
        addSearchAlias,
        cmap,
        getBrowserName,
        getFormData,
        map,
        mapkey,
        unmap,
        readText,
        tabOpenLink,
        vmapkey,
        Clipboard,
        Hints,
        Front,
        RUNTIME
    } = api;

    map('g0', ':feedkeys 99E', 0, "#3Go to the first tab");
    map('g$', ':feedkeys 99R', 0, "#3Go to the last tab");
    mapkey('uu', '#4Edit current URL with vim editor, and open in new tab', function() {
        Front.showEditor(window.location.href, function(data) {
            tabOpenLink(data);
        }, 'url');
    });
    mapkey('uU', '#4Edit current URL with vim editor, and reload', function() {
        Front.showEditor(window.location.href, function(data) {
            window.location.href = data;
        }, 'url');
    });
    mapkey('i', '#1Go to edit box', function() {
        Hints.create("input, textarea, *[contenteditable=true], *[role=textbox], select, div.ace_cursor", Hints.dispatchMouseClick);
    });
    mapkey('I', '#1Go to edit box with vim editor', function() {
        Hints.create("input, textarea, *[contenteditable=true], select", function(element) {
            Front.showEditor(element);
        });
    });
    mapkey('<Alt-p>', '#3pin/unpin current tab', function() {
        RUNTIME("togglePinTab");
    });
    mapkey('<Alt-m>', '#3mute/unmute current tab', function() {
        RUNTIME("muteTab");
    });
    mapkey('gp', '#4Go to the playing tab', function() {
        RUNTIME('getTabs', { queryInfo: {audible: true}}, response => {
            if (response.tabs?.at(0)) {
                tab = response.tabs[0]
                RUNTIME('focusTab', {
                    windowId: tab.windowId,
                    tabId: tab.id
                });
            }
        })
    }, { repeatIgnore: true });
    mapkey('S', '#4Go back in history', function() {
        history.go(-1);
    }, {repeatIgnore: true});
    mapkey('D', '#4Go forward in history', function() {
        history.go(1);
    }, {repeatIgnore: true});
    mapkey('yt', '#3Duplicate current tab', function() {
        RUNTIME("duplicateTab");
    });
    mapkey('yT', '#3Duplicate current tab in background', function() {
        RUNTIME("duplicateTab", {active: false});
    });

    unmap('f');

    function getTableColumnHeads() {
        var tds = [];
        document.querySelectorAll("table").forEach(function(t) {
            var tr = t.querySelector("tr");
            if (tr) {
                tds.push(...tr.children);
            }
        });
        return tds;
    }
    function generateFormKey(form) {
        return (form.method || "get") + "::" + new URL(form.action).pathname;
    }
}
