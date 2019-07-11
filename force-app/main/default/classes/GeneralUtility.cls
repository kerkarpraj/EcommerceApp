public with sharing class GeneralUtility {
    
    //utility method to get Group or Queue Id
    public static String getQueueGrpId(String devName){
        List<Group> groups=[select Id from Group where Type = :Constant.TYPE_Q AND DeveloperNAME = :devName];
        if(groups!=null && groups.size()>0)
            return groups[0].Id;
        return null;    
    }
}