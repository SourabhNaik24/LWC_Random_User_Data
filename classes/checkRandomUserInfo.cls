public with sharing class checkRandomUserInfo {
    @InvocableMethod(label = 'Get Random User' description = 'Get random user details from API call')
    public static List<RandomUserResponse> getRandomUserInfo(List<RandomUserRequest> requests) {
        //String flag = String.valueOf(requests[0].flag);
        randomUserDataApi.Results randomUserInfo = randomUserDataApi.getUsers();
        RandomUserResponse response = new RandomUserResponse();
        response.randomUserDescription = 'Random User Detail: Name: '+randomUserInfo.results[0].name.first+' '+randomUserInfo.results[0].name.last+' , gender: '+randomUserInfo.results[0].gender+', phone: '+randomUserInfo.results[0].phone+', email: '+randomUserInfo.results[0].email;
        return new List<RandomUserResponse>{response};
    }

    public class RandomUserRequest {
        @InvocableVariable(required = true description = 'Description of request')
        public string flag;
    }

    public class RandomUserResponse {
        @InvocableVariable(description = 'Description of random users called')
        public string randomUserDescription;
    }
}