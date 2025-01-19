({
    doInit: function(component, event, helper) {
        console.log("Initializing component...");
        helper.fetchAccounts(component);
    },

    handleRefresh: function(component, event, helper) {
        console.log("Refreshing account list...");
        helper.fetchAccounts(component);
    },

    handleRowAction: function(component, event, helper) {
        console.log("Handling row action...");
        var selectedRows = event.getParam('selectedRows');
        if (selectedRows.length > 0) {
            console.log("Selected account: ", selectedRows[0]);
            component.set("v.selectedAccount", selectedRows[0]);
        }
    }
})