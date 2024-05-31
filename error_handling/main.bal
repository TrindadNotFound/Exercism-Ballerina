import ballerina/http;
import ballerina/io;

// Use the following endpoints to send HTTP GET request to get quotes

// This is an existing endpoint (which will be automatically spawned by the test framework)
final http:Client brainyQuoteClient = check new ("http://localhost:9095/brainyquote");

// This is a non-existing endpoint.
final http:Client legacyClient = check new ("http://localhost:6060/legacyquote");

public function main() returns error? {

    // Invoke the `brainyQuoteClient` using HTTP GET request on "/"
    // Invocation returns a 'union type' which can either be an 'string' type or an 'error' type.
    // Assign it to variable.
    string|error brainyquoteReturn = brainyQuoteClient-> get("/");
    if brainyquoteReturn is error {
        io:println(brainyquoteReturn.message());
        return brainyquoteReturn;
    } else {
        io:println(brainyquoteReturn);
    }

    // Use type-guard to handle when the response is
    // 1. string
    // 2. error
    // For case with string, you need to print it the console (io:println)
    // For error case, print the error message to the console (io:println)

    // Similarly implement the same logic for the invocation of the `legacyClient` endpoint
    string|error legacyquoteReturn = legacyClient-> get("/");
    if legacyquoteReturn is error {
        io:println(legacyquoteReturn.message());
        return legacyquoteReturn;
    } else {
        io:println(legacyquoteReturn);
    }


    // Finally, use the `check` expression when retrieving the response from the `legacyClient` endpoint
    return check legacyClient -> get("/");
}
