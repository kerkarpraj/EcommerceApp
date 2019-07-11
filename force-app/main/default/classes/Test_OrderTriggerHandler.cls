@IsTest
public class Test_OrderTriggerHandler {
	public static Account acc;
    public static List<Order> orders;
    
    public static void createTestData(){
        acc=TestDataFactory.createAccount('OrderAccount');
        Insert acc;
        
        
        orders=new List<Order>();
        for(Integer i=0;i<200;i++){
            orders.add(TestDataFactory.createOrder(acc.Id,Date.today().addDays(i),'Draft'));
        }
        Insert Orders;
    }
    
    @IsTest
    public static void test_assignOrderToQueue(){
        createTestData();
        Test.startTest();
        for(order currOrd:Orders){
            currOrd.Status=Constant.STAT_PEND_APPR;
        }
        update Orders;
        
        //check that the trigger updated successully
        system.assertEquals(Constant.STAT_PEND_APPR, Orders[0].Status);
        Order updatedOrd=[SELECT OwnerId FROM Order WHERE Id=:Orders[0].Id];
        //check that the order was assigned to queue
        system.assertEquals(updatedOrd.OwnerId,GeneralUtility.getQueueGrpId(Constant.ODR_PROC_Q_DEVNAME));
        
        //negative condition check if queue not present
        system.assertEquals(null, GeneralUtility.getQueueGrpId(Constant.ODR_PROC_Q_NAME));
        

        try{
            Insert TestDataFactory.createOrder(acc.Id,Date.today(),Constant.STAT_PEND_APPR);
        }catch(DmlException de){
            //check the VR fires correctly
            system.assertEquals(StatusCode.FIELD_CUSTOM_VALIDATION_EXCEPTION,de.getDmlType(0));
        }        
        Test.stopTest();
        
    }
}