/*  
String cron = '0 0 1 * * ?'; // Executa todos os dias às 01:00
System.schedule('Warehouse Sync Job', cron, new WarehouseSyncSchedule()); */

global with sharing class WarehouseSyncSchedule implements Schedulable{
    global void execute(SchedulableContext ctx){
        System.enqueueJob(new WarehouseCalloutService());
    }
}