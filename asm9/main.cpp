#include <iostream>
#include <vector>

using namespace std;

int centuryFromYear(int year) {
    return (year + 99)/ 100;
}

int centuryLong(int year) {
    if(year%100==0)
        return year/100;
    else
        return year/100+1;
}

int main() {
    cout << centuryFromYear(2000) << '\n';
    cout << centuryLong(2002) << '\n';
    return 0;
}
