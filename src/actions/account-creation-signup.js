/**
 * Handler that will be called during the execution of a PostUserRegistration flow.
 *
 * @param {Event} event - Details about the context and user that has registered.
 * @param {PostUserRegistrationAPI} api - Methods and utilities to help change the behavior after a signup.
 */
const axios = require('axios')
exports.onExecutePostUserRegistration = async (event, api) => {
    try {
        console.log(event.user)
        console.log(event.user.user_metadata)
        let data = {
            email: event.user.email,
            userId:event.user.user_id,
            firstName: event.user.user_metadata.first_name,
            lastName: event.user.user_metadata.last_name,
            dateOfBirth: event.user.user_metadata.date_of_birth
        };
        let result = await axios.post(event.secrets.BACKEND_SIGNUP_CALLBACK, data);
        console.log(result)
        if (result.code !== 200)
        {
            throw new Error('Failed to make API call');
        } else {
            return event.user;
        }
    }
    catch(error) {
        console.log(error)
        throw new Error('Failed to make API call');
    }
};
