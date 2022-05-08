# realiza complemento a 2 de n bits al dato ingresado en binario
def complemento_2(dato, nbits):
    dato = int(dato, 2)
    if dato == 0:
        return "0"
    snxor = "1" * nbits
    resultxor = int(snxor, 2) ^ dato
    resultc2 = resultxor + 1
    binc2 = bin(resultc2)
    return binc2.replace("0b", "")

# convierte la parte decimal de un numero a binario de nbits
# devuelve un string del numero binario de nbits ej para 0.25 de 4 bits: "0100"


def decimal_a_binario(decimal, nbits):
    binario = ""
    for i in range(nbits):
        dec2 = decimal * 2
        bit = int(dec2)
        binario += str(bit)
        decimal = dec2 % 1
    return binario

# convierte la parte entera de un numero a binario de nbits ej para 4 de 3 bits: "0100"


def pentera_a_binario(entero, nbits):
    binario = bin(entero).replace("0b", "")
    completo = "0" * (nbits - len(binario)) + binario
    return completo

# convierte un numero de tipo float32 a binario de nbits con cantdecimal como la cantidad de bits que representa la parte decimal


def float_a_binario(num, nbits, cantdecimal):
    entero = int(abs(num))
    decimal = abs(num) % 1
    binario = pentera_a_binario(
        entero, nbits - cantdecimal) + decimal_a_binario(decimal, cantdecimal)
    if num < 0:
        binario = complemento_2(binario, 16)
    return binario


print(float_a_binario(30.5, 19, 10))
