#include "TestSuite.hpp"

int main() {
    TestSuite ts("C Machine Learning Test Suite");
    ts.addTest("Make Matrix", std::function<bool ()> test)
}
