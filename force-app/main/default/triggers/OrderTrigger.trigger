trigger OrderTrigger on Order (Before Insert,Before Update, After Insert,After Update) {
    
    if(OrderTriggerHandler.isEnabledOrdTgr){
        if(System.isBatch()){
            
        }else if(System.isFuture()){
            
        }else if(System.isScheduled()){
            
        }else if(System.isQueueable()){
            
        }else{
            if(Trigger.isUpdate && Trigger.isBefore){
                if(OrderTriggerHandler.isFirstTime){
                    OrderTriggerHandler.assignOrderToQueue(Trigger.new);   
                }
                OrderTriggerHandler.isFirstTime=false;   
            }
        }
    }        
    
    
    
    /*
else if(Trigger.isUpdate){
if (Trigger.isBefore) {

}else{

}
}  
*/
}