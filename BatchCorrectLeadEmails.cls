/*
* Chicago Cloud Group (c) - 2020
*
* BatchCorrectLeadEmails
*
* Created By: Alexander Miller
* Created Date: 04/11/2020
* Tested By: BatchCorrectLeadEmailsTest
* Project Item: 
* Modified By                  Alias          Modified Date           Reason
* ---------------------------------------------------------------------------
*   
*/
global class BatchCorrectLeadEmails implements Database.Stateful, Schedulable, Database.Batchable<sObject>{

    private List<String> emailFields;

    global void execute(SchedulableContext sc) 
    {
        BatchCorrectLeadEmails b = new BatchCorrectLeadEmails(); 
        database.executebatch(b, 1);
    }

    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        if(emailFields == null)
        {
            emailFields = new List<String>();
        }

        String strEmailFiels = '';

        for(Schema.SObjectField field : Lead.getSobjectType().getDescribe().fields.getMap().values())
        {
            if(Schema.DisplayType.EMAIL == field.getDescribe().getType())
            {
                strEmailFiels += ', ' + field.getDescribe().getName();
                
                emailFields.add(field.getDescribe().getName());
            }  
        }

        strEmailFiels = strEmailFiels.removeStart(',');

        System.debug(strEmailFiels);

        return Database.getQueryLocator('SELECT Id, ' + strEmailFiels + ' FROM Lead');
    }

    global void execute(Database.BatchableContext BC, List<Lead> scope)
    {
        for(Lead tempLead : scope)
        {
            for(String tempField : emailFields)
            {
                String fieldValue = (String) tempLead.get(tempField);

                if(fieldValue != null && !String.isEmpty(fieldValue))
                {
                    fieldValue = fieldValue + '.invalid';

                    tempLead.put(tempField, fieldValue);
                }
            }
        }

        update scope;
    }

    global void finish(Database.BatchableContext BC){}

}