[int, string][] ARABIC_ROMAN = [
    [1000, "M"],[900, "CM"],
    [500, "D"],[400, "CD"],
    [100, "C"],[90, "XC"],
    [50, "L"],[40, "XL"],
    [10, "X"],[9, "IX"],
    [5, "V"],[4, "IV"],
    [1, "I"]
];


function roman(int number) returns string {
    int input = number;
    string output = "";
    

    foreach [int, string] [arabicNum, romanNumber] in ARABIC_ROMAN {
        while input >= arabicNum {
            output += romanNumber;
            input -= arabicNum;
        }
    }
    return output;
}