#include <iostream>

using namespace std;
void lerVetor(int tamanho, double* vetor);

int main(int argc, char** argv){

	cout << "Este programa calcula o produto escalar " 
			<< "entre os vetores X e Y de tamanho n\n\n";

	cout << "Digite o valor de n: ";
	int n = 0;
	cin >> n;

	cout << "Entre com os elementos do vetor X:\n";
	double* vetX = new double[n];
	lerVetor(n, vetX);

	cout << "\nEntre com os elementos do vetor Y:\n";
	double* vetY = new double[n];
	lerVetor(n, vetY);

	//Cáculo do produto escalar X * Y
	double produtoEscalar = 0;
	for (int i = 0; i < n; ++i)
	{
		produtoEscalar += vetX[i] * vetY[i];
	}

	cout << "Produto escalar X * Y = " << produtoEscalar << "\n";

	return 0;
}

//Função que lê um vetor de doubles, recebendo seu tamanho 
//e um ponteiro para sua base
void lerVetor(int tamanho, double* vetor){
	for (int i = 0; i < tamanho; ++i){
		cout << "Elemento " << i + 1 << ": ";
		double elemento = 0;
		cin >> elemento;
		vetor[i] = elemento; 
	}
}