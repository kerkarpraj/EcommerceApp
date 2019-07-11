public with sharing class OrderTriggerHandler {
    public static Boolean isFirstTime=true;
    public static Boolean isEnabledOrdTgr=true;

	//Assigns the order to Order Processing queue once the order submitted
	public static void assignOrderToQueue(List<Order> orders){
        Id orderProcessingQueueId=GeneralUtility.getQueueGrpId(Constant.ODR_PROC_Q_DEVNAME);

        if(orderProcessingQueueId!=null){
            for(Order currentOrder:orders){
                if(currentOrder.Status==Constant.STAT_PEND_APPR){
                    currentOrder.ownerId=orderProcessingQueueId;
                }
            }
        }else{
            System.debug('Unable to Assign Order to Order Processing Queue');
        }
        
    }
    
   
}