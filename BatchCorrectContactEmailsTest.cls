/*
* Chicago Cloud Group (c) - 2020
*
* BatchCorrectContactEmailsTest
*
* Created By: Alexander Miller
* Created Date: 04/11/2020
* Tested By: BatchCorrectContactEmailsTest
* Project Item: 
* Modified By                  Alias          Modified Date           Reason
* ---------------------------------------------------------------------------
*
*/
@isTest
public class BatchCorrectContactEmailsTest { 

    @TestSetup
    static void makeData() 
    {
        TestDataFactory.createContact(null, true);
    }

    static TestMethod void testBatchClass(){
        
        Test.startTest();

        Database.executeBatch(new BatchCorrectContactEmails(), 1);

        Test.stopTest();
    }

    static TestMethod void testScheduleableClass(){
        
        Test.startTest();

        BatchCorrectContactEmails sh1 = new BatchCorrectContactEmails();

        String sch = '0 0 23 * * ?'; 

        System.schedule('BatchCorrectContactEmails test', sch, sh1);  
        
        Test.stopTest();
    }
}