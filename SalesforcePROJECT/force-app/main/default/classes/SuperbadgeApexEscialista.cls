public with sharing class SuperbadgeApexEscialista implements Queueable {
    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    @future(callout=true)
    public static void sincronizarEquipamentos(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WAREHOUSE_URL);
        request.setMethod('GET');
        
        HttpResponse response;
        try {
            response = http.send(request);
            if (response.getStatusCode() == 200) {
                processResponse(response.getBody());
            } else {
                System.debug('Erro na chamada: ' + response.getStatusCode() + ' - ' + response.getStatus());
            }
        } catch (Exception e) {
            System.debug('Erro ao realizar a chamada: ' + e.getMessage());
        }
    }
    
    private static void processResponse(String responseBody) {
        List<Product2> warehouseEq = new List<Product2>();
        List<Object> jsonResponse = (List<Object>)JSON.deserializeUntyped(responseBody);
        
        for (Object eq : jsonResponse) {
            Map<String,Object> mapJson = (Map<String,Object>)eq;
            Product2 myEq = new Product2();
            myEq.Replacement_Part__c = (Boolean) mapJson.get('replacement');
            myEq.Name = (String) mapJson.get('name');
            myEq.Maintenance_Cycle__c = (Integer) mapJson.get('maintenanceperiod');
            myEq.Lifespan_Months__c = (Integer) mapJson.get('lifespan');
            myEq.Cost__c = (Integer) mapJson.get('cost');
            myEq.Warehouse_SKU__c = (String) mapJson.get('sku');
            myEq.Current_Inventory__c = (Double) mapJson.get('quantity');
            myEq.ProductCode = (String) mapJson.get('_id');
            warehouseEq.add(myEq);
        }
        
        if (!warehouseEq.isEmpty()) {
            upsert warehouseEq;
            System.debug('Seu equipamento foi sincronizado com o do armazém');
        }
    }
    
    public static void execute (QueueableContext context){
        sincronizarEquipamentos();
    }
}