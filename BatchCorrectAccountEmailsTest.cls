/*
* Chiacgo Cloud Group (c) - 2020
*
* BatchCorrectAccountEmailsTest
*
* Created By: Alexander Miller
* Created Date: 04/11/2020
* Tested By: BatchCorrectAccountEmailsTest
* Project Item:
* Modified By                  Alias          Modified Date           Reason
* ---------------------------------------------------------------------------
*
*/
@isTest
public class BatchCorrectAccountEmailsTest {
 
    @TestSetup
    static void makeData()
    {
        TestDataFactory.createAccount(null, null, true);
    }

    static TestMethod void testBatchClass(){
        
        Test.startTest();

        Database.executeBatch(new BatchCorrectAccountEmails(), 1);

        Test.stopTest();
    }

    static TestMethod void testScheduleableClass(){
        
        Test.startTest();

        BatchCorrectAccountEmails sh1 = new BatchCorrectAccountEmails();

        String sch = '0 0 23 * * ?'; 

        System.schedule('BatchCorrectAccountEmails test', sch, sh1); 
        
        Test.stopTest();
    }
}