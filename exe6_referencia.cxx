#include <iostream>

using namespace std;

int main(int argc, char **argv)
{
	cout << "Este programa executa a soma (1/n) + (2/n-1) + ... + (n/1)"
			<<"\n\n";
	
	cout << "Digite o valor de n: ";
	int n = 0;
	cin >> n;
	
	double soma = 0;
	for (int i = 1; i <= n; i++)
	{
		soma += (float)i/(n - i + 1);
	}
	
	cout << "\nO valor da soma até o " << n << "° termo é : " << soma
			<< "\n";
	return 0;
}

