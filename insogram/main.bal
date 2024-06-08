import ballerina/regex;

public function isIsogram(string sentence) returns boolean {
    
    string lowCaseWord = regex:replaceAll(sentence.toLowerAscii(), "[ -]+", "");
    string[] letters = regex:split(lowCaseWord, "");
    string[] splitWord = [];

    foreach string i in letters {
        if splitWord.indexOf(i) != () {
            return false;
        }

        splitWord.push(i);
    }

    return true;
}