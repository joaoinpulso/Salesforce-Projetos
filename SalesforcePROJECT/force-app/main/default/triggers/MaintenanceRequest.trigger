trigger MaintenanceRequest on Case (before update,after update) {
    if(Trigger.isUpdate && Trigger.isAfter){

        MaintenanceRequestHelper.atualizaOrdensTrabalho(Trigger.New, Trigger.OldMap);

    }
}