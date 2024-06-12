# Returns Bob's response to someone talking to him.
#
# + input - whatever is said to Bob
# + return - Bob's response
public function hey(string input) returns string {
    // TODO: implement this function
    
    string trimInput = input.trim();
    
    boolean isQuestion = trimInput.endsWith("?");
    boolean isEmpty = trimInput.length() == 0;
    boolean isYell = (trimInput == trimInput.toUpperAscii()) && (trimInput != trimInput.toLowerAscii());

    if(isEmpty) {
        return "Fine. Be that way!";

    } else if (isQuestion && isYell) {
         return "Calm down, I know what I'm doing!";

    } else if (isQuestion) {
        return "Sure.";

    } else if (isYell) {
        return "Whoa, chill out!";
    }
    
    return "Whatever.";
}