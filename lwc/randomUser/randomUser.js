/*--------------------------------------------------------------------------------------------------
Name:       randomUser.js
Purpose:    A JavaScript for randomUser LWC component
------------------------------History---------------------------------------------------------------
Version     Author                Date                 Detail Description
-------     ---------------       --------------       ------------------
1.0         Sourabh Naik          15th May 2022        Initial Development
---------------------------------------------------------------------------------------------------*/
import { LightningElement, track } from 'lwc';
import getUser from '@salesforce/apex/randomUserDataApi.getUsers'; // Call randomUserDataApi Class and getUsers Method

export default class RandomUser extends LightningElement {
    // Create below variables
    @track userData;
    picture;
    name;
    email;
    age;
    phone;
    gender;
    city;

    connectedCallback () {
        // try when we get the user data
        getUser().then((result) =>{
            this.userData = JSON.parse(JSON.stringify(result.results[0])); // Parse the data to become JS Object
            // Assigning appropriate values for each variables from the apex class
            this.picture = this.userData.picture.large;
            this.email = this.userData.email;
            this.phone = this.userData.phone;
            this.name = this.userData.name.first + " " + this.userData.name.last;
            this.age = this.userData.dob.age;
            this.gender = this.userData.gender;
            this.city = this.userData.location.city;
            console.log("🚀 ~ result", this.userData.picture.large);
        })
        // Catch an error when we don't get any user data
        .catch((error) => {
            console.log("--->Error during callout : " + JSON.stringify(error));
        });
    }
}