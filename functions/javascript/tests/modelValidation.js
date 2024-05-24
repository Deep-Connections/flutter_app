
// const assert = require("assert");


// validateMessage(message) {

//     const runtimeType = message.runtimeType;
//     if (runtimeType === undefined || runtimeType === "default"){
//         assert.isString(message)
//     }
//     assert.isString(runtimeType, 'runtimeType should be a string');
//     if (runtimeType in ["delete", "unmatch"]){
//         assert.isString(runtimeType, 'runtimeType should be a string');
//     }


//     assert.isObject(message, 'Data should be an object');
//     assert.isString(message.senderId, 'senderId should be a string');
//     assert.isArray(message.participantIds, 'participantIds should be an array');
//     assert.isString(message.senderFirstName, 'senderFirstName should be a string');
//     message.participantIds.forEach(id => assert.isString(id, 'Each participantId should be a string'));

// }
