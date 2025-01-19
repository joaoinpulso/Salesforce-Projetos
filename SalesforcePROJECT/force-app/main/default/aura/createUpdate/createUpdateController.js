({
    handleClick : function(component, event, helper) {
        console.log("foi chamado");
        var action = component.get("c.updateOrInsertMovie");
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                $A.get("e.force:showToast").setParams({
                    "title": "Sucesso!",
                    "message": "Operação realizada com sucesso."
                }).fire();
                $A.get("e.force:closeQuickAction").fire();
            } else if (state === "ERROR") {
                var errors = response.getError();
                console.error(errors);
                var errorMessage = errors && errors.length > 0 ? errors[0].message : "Erro desconhecido.";
                
                $A.get("e.force:showToast").setParams({
                    "title": "Erro",
                    "message": errorMessage,
                    "type": "error"
                }).fire();
            }
        });

        $A.enqueueAction(action);
    }
})