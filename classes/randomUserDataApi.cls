/*--------------------------------------------------------------------------------------------------
Name:       randomUserDataApi.cls
Purpose:    An Apex Custom REST Service Returning Random Users Info From https://randomuser.me/ URL
------------------------------History---------------------------------------------------------------
Version     Author                Date                 Detail Description
-------     ---------------       --------------       ------------------
1.0         Sourabh Naik          15th May 2022        Initial Development
---------------------------------------------------------------------------------------------------*/
public with sharing class randomUserDataApi {
    /*
    * Method Name: getUsers
    * Return Type: ressult wrapper class
    * Parameter: NA
    */
    @AuraEnabled
    public static results getUsers() {
        try {
            string endPoint = 'https://randomuser.me/api/'; // Take endpoint for communication
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(endPoint); // Set endpoint for http request to server side of that url
            request.setMethod('GET'); // Set method i.e. GET to retrieve resource from that endpoint
            // system.debug(request);
            HttpResponse response = http.send(request); // Store the requested data into a http response
            // system.debug('---Response : '+response.getBody());
            Results getUser = new Results();
            getUser = (Results)System.JSON.deserialize(response.getBody(), Results.class); // Converting a JSON string to an equivalent Salesforce format
            return getUser;
        }
        catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Wrapper class for list of ResultsWrapper
    public class Results {
        @AuraEnabled public List<ResultsWrapper> results;
    }

    // Wrapper class for DOB - age
    public class DOB {
        @AuraEnabled public string age;
    } 

    // Wrapper class for Name - first and last names
    public class NAME {
        @AuraEnabled public string first;
        @AuraEnabled public string last;
    }

    // Wrapper class for Picture - large size
    public class PICTURE {
        @AuraEnabled public string large;
    }

    // Wrapper class for location - city
    public class LOCATION {
        @AuraEnabled public string city;
    }

    // Wrapper Class for the JSON properties to store in string of fields or another wrapper class
    public class ResultsWrapper { 
        @AuraEnabled public DOB dob;
        @AuraEnabled public string email;
        @AuraEnabled public NAME name;
        @AuraEnabled public string phone;
        @AuraEnabled public PICTURE picture;
        @AuraEnabled public string gender;
        @AuraEnabled public LOCATION location;
    }
}
