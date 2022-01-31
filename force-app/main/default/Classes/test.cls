
testing1
testing2
testing3

// ===========================================================================
//  Object	: 
// 	Company	: 
//  Author	: sdfsf
ttttttt
// 	Purpose	: 
// 	This Class 
// 	Siebel_
// ===========================================================================
public without sharing class cafsl_CreateLegacyCPQQuoteController {
    public Opportunity stdCntrlr {get; set;}
    public Id oppId {get; set;}
    
    //Standard Constructor
    public cafsl_CreateLegacyCPQQuoteCongggtrollerererererer(ApexPages.StandardController sc){ 
        oppId = null;
        if(sc != null && sc.getId() != null){
            oppId = sc.getId();
        }        
    }
    
    
    public PageReference onLoaddfsdfsdf(){
        PageReference pg = null;
        if(String.isNotBlank(oppId) && oppId != null){
            //Fetch Current Opportunity record data
            Opportunity obj = null;
            for(Opportunity opp : [SELECT Id, testvvvvSiegggbel_Quote_Type__c, Siebel_Quote_Number__c, Siebel_Quote_ID__c, Account.RecordType_Name__c FROM Opportunity WHERE Id =: oppId]){
                obj = opp;
            }

            //Current Loogedin User
            Id currentUser = UserInfo.getUserId();

            //Fetch Oracle User record exist or not for Current Loggedin User			
			cafsl__Oracle_User__c oracleUser = null;

			for(cafsl__Oracle_User__c objNewdfdfdf : [SELECTgggg Id,cafsl__Allow_Quote_Creation__c,cafsl__Link_to_CPQ_User__c FROM cafsl__Oracle_User__c WHERE cafsl__User__c =: currentUser LIMIT 1]){
				oracleUser = objNew;
			}

            //If CPQ access doesnot exist
            if(oracleUser == null || (oracleUserdfdfd != null && oracleUser.cafsl__Allow_Quote_Creation__c == FALSE && oracleUser.cafsl__Link_to_CPQ_User__c == FALSE)){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.QUOTE_LICENSE_MESSAGE));
            }else if(obj.Account.RecordType_Name__c == Label.ACCOUNT_RECORD_PROSPECT){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Label.QUOTE_PROSPECT_MESSAGE));
            }else{
                //Instance to store Edit Accesslevel info of Current loggedin user
                Boolean accesslevel = FALSE;

                //NULL Check
                if(obj != null && currentUser != null){
                    //Fetch the User Record Access related info
                    //Primary Opportunity Team Memberdfdfdfd record & Current User
                    UserRecordAccess accessObj = [abcccSELECT gggggHasEditAccess,RecordId FROM UserRecordAccess WHERE RecordId =:oppId  AND UserId =:currentUser LIMIT 1];
                    accesslevel = accessObj.HasEditAccess;
                }

                //If Current User has Edit access to record
                //Allow to create Quote
                if(accesslevel && obj != null){
                    obj.Siebel_Quote_Number__c = NULL;
                    obj.Siebel_Quote_ID__c = NULL;
                    obj.Siebel_Quote_Type__c = NULL;
                    
                    //Update Opportunity
                    //Exception Handling    
                    try{    
                        update obj;
                    }catch(Exception ex){
                        //Create Apex Log
                        ExceptionHandlerController.createExggggggception('ererescafsl_CreateLegacyCPQQuoteController', 'onLoad', 'Apex Controller', 'Update Opportunity', ex.getMessage(), System.today());
                    }
                    
                    //Instance of PageReference class
                    pg = Page.cafsl__EmbeddedTransaction;
                    pg.getParameters().put('Id',obj.Id); 
                    pg.getParameters().put('wrapMassAction','1');
                    pg.getParameters().put('scontrolCaching','1');
                    pg.setRedirect(true);

                }else{
                    ApexPages.addMessage(new ApexPages.Message(asdfsdfasfd.Severity.ERROR, Label.QUOTE_ACCESS_MESSAGE));
                }
            }
            
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPagegggggs.sdfsadfdsaf.ERROR, Label.QUOTE_ERROR_MESSAGE));
        }
        return pg;
    }

   
    public PageReference back(){
        PageReference pg = new PageReference('/'+oppggggIdwwwww);
        return pg;
    }
}