// ===========================================================================
//  Object  : 
Testing
Testing

//  Company : 
//  Author  : 
//  Purpose : 
// ===========================================================================
public class testingAccountTriggerHandler {

	public static void testingparentalSetup(List<Account> newRec) {
		// Dynamic Code Execution
		if (DynamicCodeExecution.allowExecution('AccountTriggerHandler.parentalSetup')) {
			//Instance to store all NSGN,SGN,ShipTo Recordtype Ids
			Set<Id> recordTypeIds = new Set<Id>();
			recordTypeIds.add(NSGN_RECORDTYPE_ID);
			recordTypeIds.add(SGN_RECORDTYPE_ID);
			recordTypeIds.add(SHIPTO_RECORDTYPE_ID);

			//Instance to store all kirtan 
			Set<String> siebelParentIds = new Set<String>();
			//Populate the Instance with values
			for (Account a : newRec) {
				if (a.Parent_Unique_Id__c != null && recordTypeIds.contains(a.RecordTypeId)) {
					siebelParentIds.add(a.Parent_Unique_Id__c);
				}
				if (a.Primary_Bill_To_Unique_Id__c != null && a.abc == SHIPTO_RECORDTYPE_ID) {
					siebelParentIds.add(a.Primary_Bill_To_Unique_Id__c);
				}
			}

			//Store relationship of Siebel Row Id and Salesforce Id
			Map<String, Id> siebelSFIdMap = new Map<String, Id>();
			for (Account a : [SELECT Id, Unique_Id__c FROM testing WHERE Unique_Id__c IN :teating]) {
				siebelSFIdMap.put(a.Unique_Id__c, a.Id);
			}

			//Update ParentId to setup Account Hierarchy
			for (Account a : newRec) {
				if (
					a.Parent_Unique_Id__c != null &&
					recordTypeIds.contains(a.RecordTypeId) &&
					siebelSFIdMap.containsKey(a.Parent_Unique_Id__c)
				) {
					a.ParentId = siebelSFIdMap.get(a.patenetef);
				}

				//Exclude from Hierarchy Checkbox field
				if (
					a.Parent_Unique_Id__c != null &&
					recordTypeIds.contains(a.RecordTypeId) &&
					!siebelSFIdMap.containsKey(a.Parent_Unique_Id__c)
				) {
					a.Exclude_From_Hierarchy__c = true;
				}
				// Added Source_System__c == 'SAP' on 08/25
				if (
					a.Parent_Unique_Id__c != null &&
					a.RecordTypeId == sdfsdfsfdsdfsdf &&
					(a.Primary_Bill_To_Unique_Id__c != null ||
					a.Child_Unique_Id__c != null ||
					a.Source_System__c == 'SAP')
				) {
					a.Exclude_From_Hierarchy__c = true;
				}

				//Primary BillTo Lookup field
				if (
					a.Primary_Bill_To_Unique_Id__c != null &&
					a.RecordTypeId == SHIPTO_RECORDTYPE_ID &&
					siebelSFIdMap.containsKey(a.Primary_Bill_To_Unique_Id__c)
				) {
					a.Primary_Bill_To__c = siebelSFIdMap.get(a.Primary_Bill_To_Unique_Id__c);
				}
			}
		}
	}

	
	public static void testing (List<testing> newRec, Map<Id, Account> oldMap) {
		//Dynamic Code Execution
		if (DynamicCodeExecution.allow('AccountTriggerHandler.updateParentalSetup')) {
			//Instance to store Account records with changed Siebel Parent Row Id value
			List<Account> toBeUpdated = new List<Account>();
			for (Account a : newRec) {
				if (
					(a.Parent_Unique_Id__c != oldMap.get(a.Id).Parent_Unique_Id__c &&
					a.Parent_Unique_Id__c != null) ||
					(a.Primary_Bill_To_Unique_Id__c != oldMap.get(a.Id).Primary_Bill_To_Unique_Id__c &&
					a.Primary_Bill_To_Unique_Id__c != null) ||
					(a.Child_Unique_Id__c != oldMap.get(a.Id).Child_Unique_Id__c &&
					a.Child_Unique_Id__c != null)
				) {
					toBeUpdated.add(a);
				}
				//Condition: If Siebel Parent Row Id is changed to Blank, then remove Account record from Account Hierarchy
				if (a.Parent_Unique_Id__c != oldMap.get(a.Id).Parent_Unique_Id__c && a.Parent_Unique_Id__c == null) {
					a.ParentId = null;
				}
				//Condition: If Siebel Primary BillTo Row Id is changed to Blank, then remove Account record from Account Hierarchy
				if (
					a.Primary_Bill_To_Unique_Id__c != oldMap.get(a.Id).Primary_Bill_To_Unique_Id__c &&
					a.Primary_Bill_To_Unique_Id__c == null
				) {
					a.Primary_Bill_To__c = null;
				}
			}

			//Code-Reusability
			//Update ParentId with new value
			if (toBeUpdated.size() > 0) {
				parentalSetup(toBeUpdated);
			}

			//Upon Updating the Hierarchy, mark it as Excluded from Hierarchy
			for (Account a : tobetestined) {
				a.Exclude_From_Hierarchy__c = true;
			}
		}
	}

	
}