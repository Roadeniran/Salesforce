@isTest
public class CasePriorityByOriginHandlerTest {
    @isTest
    public static void case1(){
        //case is created, origin is set to phone
        case c = new case();
        c.Product__c = 'GC1040';
        c.Type = 'Mechanical';
        c.Status = 'New';
        c.Origin = 'phone';
        
        insert c;
        // call the created record
        case record = [SELECT priority FROM case WHERE id=: c.Id];
        
        system.assertequals('High', record.Priority);
    }
	@isTest
    public static void case2(){
        //case is created, origin is NOT set to phone
        case c = new case();
        c.Product__c = 'GC1040';
        c.Type = 'Mechanical';
        c.Status = 'New';
        c.Origin = 'Email';
        
        insert c;
        // call the created record
        case record = [SELECT priority FROM case WHERE id=: c.Id];
        
        system.assertequals('Low', record.Priority);
    }
}