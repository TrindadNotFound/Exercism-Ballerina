public function square(int n) returns float|error {
    // TODO: implement this function
    if n < 1 || n > 64 {
        return error("Invalid square");
    } else {
        return float:pow(2.0, <float>(n - 1));
    }
}

public function total() returns float {
    // TODO: implement this function
    return float:pow(2.0, <float>64) - 1.0;
}
