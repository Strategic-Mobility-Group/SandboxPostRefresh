/*
* Chicago Cloud Group (c) - 2020
*
* BatchCorrectLeadEmailsTest
*
* Created By: Alexander Miller
* Created Date: 04/11/2020
* Tested By: BatchCorrectLeadEmailsTest
* Project Item:
* Modified By                  Alias          Modified Date           Reason
* ---------------------------------------------------------------------------
*
*/
@isTest
public class BatchCorrectLeadEmailsTest { 

    @TestSetup
    static void makeData() 
    {
        TestDataFactory.createLead(null, null, null, true);
    }

    static TestMethod void testBatchClass(){
        
        Test.startTest();

        Database.executeBatch(new BatchCorrectLeadEmails(), 1);

        Test.stopTest();
    }

    static TestMethod void testScheduleableClass(){
        
        Test.startTest();

        BatchCorrectLeadEmails sh1 = new BatchCorrectLeadEmails();

        String sch = '0 0 23 * * ?'; 

        System.schedule('BatchCorrectLeadEmails test', sch, sh1); 
        
        Test.stopTest();
    }
}