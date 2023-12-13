#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <vector>

using std::endl;
using std::cout;
using std::cerr;
using std::ifstream;
using std::istream;
using std::string;
using std::stringstream;
using std::vector;
using std::getline;

bool DoubleEquals(double a, double b, double epsilon = 1e-4);
bool CheckList(istream& input, const double data[], unsigned int size);

int main(int argc, char* argv[]){
    istream* input = nullptr;
    if (argc == 2){ // input file provided
        input = new ifstream(argv[1]);
        if (input->fail()){
            cerr << "Unable to open file: " << argv[1] << endl;
            return 1;
        }
    }else{
        input = new stringstream(
                "2.8069999999999995\n"
                "1742.1\n"
                "0.22947984660967502\n"
                "52.93666026488638\n"
                "0.00252447\n"
                "-1.59088\n"
                "0.582348\n"
                "[10,11,12,14,9]\n"
                "[10,11,12,14,9]\n"
                "[1714,1664,1760,1685,1693,1764,1764,1792,1850,1735]\n"
                );
    }

    // Expected Values
    const double MEANG = 2.8070;
    const double MEANS = 1742.1;
    const double STDG = 0.2295;
    const double STDS = 52.9367;
    const double ALPHA = 0.0025;
    const double BETA = -1.5909;
    const double R = 0.5823;
    const double GPAS[] = {2.4,2.52,2.54,2.74,2.83,3,3,3.01,3.01,3.02};
    const double SATS[] = {1714,1664,1760,1685,1693,1764,1764,1792,1850,1735};
    const double DATA[] = {10,11,12,14,9};
    const unsigned int SIZE_GPA_SAT = 10;
    const unsigned int SIZE_DATA = 5;

    string list, element;
    stringstream parseStream;
    double value;

    unsigned int total = 0;
    const unsigned int TOTAL = 10;

    *input >> value;
    total += (DoubleEquals(value, MEANG) ? 1 : 0);

    *input >> value;
    total += (DoubleEquals(value, MEANS) ? 1 : 0);

    *input >> value;
    total += (DoubleEquals(value, STDG) ? 1 : 0);

    *input >> value;
    total += (DoubleEquals(value, STDS) ? 1 : 0);

    *input >> value;
    total += (DoubleEquals(value, ALPHA) ? 1 : 0);

    *input >> value;
    total += (DoubleEquals(value, BETA) ? 1 : 0);

    *input >> value;
    total += (DoubleEquals(value, R) ? 1 : 0);

    total += (CheckList(*input, DATA, SIZE_DATA) ? 1 : 0);
    total += (CheckList(*input, DATA, SIZE_DATA) ? 1 : 0);
    total += (CheckList(*input, SATS, SIZE_GPA_SAT) ? 1 : 0);

    cout << total << endl;

    return 0;
}

bool DoubleEquals(double a, double b, double epsilon){
    return std::abs(a - b) < epsilon;
}

bool CheckList(istream& input, const double data[], unsigned int size){
    unsigned int e = 0;
    bool unmatched = false;
    double value;
    string element, list;
    stringstream parseStream;

    input >> list;
    list = list.substr(1, list.length() - 2);
    parseStream.str(list);

    while(getline(parseStream, element, ',') && e < size) {
        value = stof(element);
        if (!DoubleEquals(value, data[e++])){
            unmatched = true;
            break;
        }
    }
    return !unmatched;

}
