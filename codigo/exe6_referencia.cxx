#include <iostream>

int main(int argc, char **argv)
{
	cout << "Este programa executa a soma (1/n) + (2/n-1) + ... + (n/1)"
	
	cout << "Digite o valor de n: "
	int n = 0;
	cin >> n;
	
	double soma = 0f;
	for (int i = 1; i <= n; i++)
	{
		soma += i/(n - i + 1);
	}
	
	cout << "O valor da soma até o " << n << "° termo é : " << soma;
	return 0;
}

