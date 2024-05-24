const Collections = {
  PROFILES: "profiles",
  CHATS: "chats",
  MESSAGES: "messages",
};

const FieldName = {
  SENDER_ID: "senderId",
  PARTICIPANT_IDS: "participantIds",
  RUNTIME_TYPE: "runtimeType",
};

const FunctionErrors = {
  OK: "ok", // (200) - No error, operation successful.
  INVALID_ARGUMENT: "invalid-argument", // (400) - Client specified an invalid argument.
  OUT_OF_RANGE: "out-of-range", // (400) - Operation was attempted past the valid range.
  UNAUTHENTICATED: "unauthenticated", // (401) - The request does not have valid authentication
  // credentials for the operation.
  PERMISSION_DENIED: "permission-denied", // (403) - The caller does not have permission to execute
  // the specified operation.
  NOT_FOUND: "not-found", // (404) - Specified resource was not found.
  ABORTED: "aborted", // (409) - Operation was aborted, typically due to a concurrency issue like the
  // transaction aborts, etc.
  ALREADY_EXISTS: "already-exists", // (409) - The resource being created already exists.
  FAILED_PRECONDITION: "failed-precondition", // (412) - Operation was rejected because the system is
  // not in a state required for the operation's execution.
  RESOURCE_EXHAUSTED: "resource-exhausted", // (429) - Some resource has been exhausted, perhaps a
  // per-user quota, or perhaps the entire file system is out of space.
  CANCELLED: "cancelled", // (499) - Client cancelled the request.
  UNKNOWN: "unknown", // (500) - Unknown error occurred.
  INTERNAL: "internal", // (500) - Internal server error.
  DATA_LOSS: "data-loss", // (500) - Unrecoverable data loss or corruption.
  UNIMPLEMENTED: "unimplemented", // (501) - Operation is not implemented or not supported/enabled in this service.
  UNAVAILABLE: "unavailable", // (503) - The service is currently unavailable (overloaded or down).
  DEADLINE_EXCEEDED: "deadline-exceeded", // (504) - Deadline expired before operation could complete.
};

module.exports = { Collections, FieldName, FunctionErrors };

