({
    fetchAccounts: function(component) {
        console.log("Fetching accounts from server...");

        var action = component.get("c.getAccounts");

        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log("Server response state: " + state);

            if (state === "SUCCESS") {
                var accounts = response.getReturnValue();
                console.log("Accounts fetched successfully:", accounts);
                component.set("v.accounts", accounts);
            } else {
                var errors = response.getError();
                console.error("Failed to fetch accounts: ", errors);
                alert("Erro ao buscar contas: " + (errors[0] && errors[0].message ? errors[0].message : "Unknown Error"));
            }
        });

        $A.enqueueAction(action);
    }
})