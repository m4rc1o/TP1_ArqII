#include <iostream>
using namespace std;

int claculaPotencia(int m, int n){
	int result = 1;
	for (int i = 0; i < n; ++i) {
		result *= m;
	}
	return result;
}



int main(){
	cout << "Calcula a potencia mˆn" <<endl;

	int m,n;
	cout << "Digite o valor de m: ";
	cin >> m;
	cout << "Digite o valor de n: ";
	cin >> n;

	cout << "P(m,n) = "<< claculaPotencia(m,n) << endl;

	
return 0;

}