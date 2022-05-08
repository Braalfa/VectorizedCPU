import numpy as np

# ================================= REGISTROS

VEC_INPUT_R = np.full((6,), 0)
VEC_INPUT_G = np.full((6,), 0)
VEC_INPUT_B = np.full((6,), 0)

VEC_RESULT_R = np.full((6,), 0)
VEC_RESULT_G = np.full((6,), 0)
VEC_RESULT_B = np.full((6,), 0)

VEC_TMP_1 = np.full((6,), 0)

ESC_TMP_1 = 0
ESC_SELECTION = 1
ESC_INDEX = 0

# =================================

# ================================= IGNORAR
MEM_AUX = (open("assets/mem_entrada.txt", "r+")).readlines()
WIDTH = 19


def AUX_read_mem(dir):
    line = MEM_AUX[dir]
    result = np.zeros((6,))
    for i in range(6):
        result[i] = int(line[i*WIDTH:(i+1)*WIDTH], base=2)/(2**10)
    return result


def AUX_write_mem(dir, vector):
    result = ""
    for i in range(6):
        result += "{:09b}".format(int(vector[i]))+"0"*10
    result += "\n"
    MEM_AUX[dir] = result

# =================================


def sepia():
    global VEC_INPUT_R, VEC_INPUT_G, VEC_INPUT_B, VEC_RESULT_R, VEC_RESULT_G, VEC_RESULT_B

    # outputRed = (inputRed × 0,393) + (inputGreen × 0,769) + (inputBlue × 0,189)
    VEC_RESULT_R = np.full((6,), 0)

    ESC_TMP_1 = .393
    VEC_TMP_1 = ESC_TMP_1 * VEC_INPUT_R
    VEC_RESULT_R = VEC_RESULT_R + VEC_TMP_1

    ESC_TMP_1 = .769
    VEC_TMP_1 = ESC_TMP_1 * VEC_INPUT_G
    VEC_RESULT_R = VEC_RESULT_R + VEC_TMP_1

    ESC_TMP_1 = .189
    VEC_TMP_1 = ESC_TMP_1 * VEC_INPUT_B
    VEC_RESULT_R = VEC_RESULT_R + VEC_TMP_1

    # outputGreen = (inputRed × 0,349) + (inputGreen × 0,686) + (inputBlue × 0,168)
    VEC_RESULT_G = np.full((6,), 0)

    ESC_TMP_1 = .349
    VEC_TMP_1 = ESC_TMP_1 * VEC_INPUT_R
    VEC_RESULT_G = VEC_RESULT_G + VEC_TMP_1

    ESC_TMP_1 = .686
    VEC_TMP_1 = ESC_TMP_1 * VEC_INPUT_G
    VEC_RESULT_G = VEC_RESULT_G + VEC_TMP_1

    ESC_TMP_1 = .168
    VEC_TMP_1 = ESC_TMP_1 * VEC_INPUT_B
    VEC_RESULT_G = VEC_RESULT_G + VEC_TMP_1

    # outputBlue = (inputRed × 0,272) + (inputGreen × 0,534) + (inputBlue × 0,131)
    VEC_RESULT_B = np.full((6,), 0)

    ESC_TMP_1 = .272
    VEC_TMP_1 = ESC_TMP_1 * VEC_INPUT_R
    VEC_RESULT_B = VEC_RESULT_B + VEC_TMP_1

    ESC_TMP_1 = .534
    VEC_TMP_1 = ESC_TMP_1 * VEC_INPUT_G
    VEC_RESULT_B = VEC_RESULT_B + VEC_TMP_1

    ESC_TMP_1 = .131
    VEC_TMP_1 = ESC_TMP_1 * VEC_INPUT_B
    VEC_RESULT_B = VEC_RESULT_B + VEC_TMP_1


def grey():
    global VEC_INPUT_R, VEC_INPUT_G, VEC_INPUT_B, VEC_RESULT_R, VEC_RESULT_G, VEC_RESULT_B

    # luminisity method
    # https://www.baeldung.com/cs/convert-rgb-to-grayscale#3-luminosity-method

    VEC_RESULT_R = np.full((6,), 0)

    ESC_TMP_1 = .300
    VEC_TMP_1 = ESC_TMP_1 * VEC_INPUT_R
    VEC_RESULT_R = VEC_RESULT_R + VEC_TMP_1

    ESC_TMP_1 = .590
    VEC_TMP_1 = ESC_TMP_1 * VEC_INPUT_G
    VEC_RESULT_R = VEC_RESULT_R + VEC_TMP_1

    ESC_TMP_1 = .110
    VEC_TMP_1 = ESC_TMP_1 * VEC_INPUT_B
    VEC_RESULT_R = VEC_RESULT_R + VEC_TMP_1

    VEC_RESULT_G = VEC_RESULT_R
    VEC_RESULT_B = VEC_RESULT_R


def negative():
    global VEC_INPUT_R, VEC_INPUT_G, VEC_INPUT_B, VEC_RESULT_R, VEC_RESULT_G, VEC_RESULT_B

    VEC_RESULT_R = np.full((6,), 255)
    VEC_RESULT_R = VEC_RESULT_R - VEC_INPUT_R

    VEC_RESULT_G = np.full((6,), 255)
    VEC_RESULT_G = VEC_RESULT_G - VEC_INPUT_G

    VEC_RESULT_B = np.full((6,), 255)
    VEC_RESULT_B = VEC_RESULT_B - VEC_INPUT_B


# ____________________________/ NOTAS
# 3 decimales + 3 digitos -> 6 digitos dec -> 20bits
# maxima multiplciacion: 255' x 1'000 =  255'000 -> 18bits
# Preguntas:
#       *Como se haría el ciclo? como se finalizaría? VECTOR DE 1111, operar con AND
#       *Formato de txt->memoria es correcto? SI
#       *Los datos que se guardan son de 255 (8bits), pero las operaciones decimales? se pueden redonder antes de ir a memoria
#       *=> registros (decimal 8bits [max 255], fración 10bits [3 digitos]) 19bits => 150.333
#       *=> memoria 19bits => 150.000


ESC_SELECTION = 0
ESC_INDEX = 0

while True:
    # print(ESC_INDEX)

    ESC_TMP_1 = 100*96/2
    if (ESC_INDEX >= ESC_TMP_1):
        break

    VEC_INPUT_R = AUX_read_mem(ESC_INDEX)
    ESC_TMP_1 = 1
    ESC_INDEX = ESC_INDEX + ESC_TMP_1

    VEC_INPUT_G = AUX_read_mem(ESC_INDEX)
    ESC_TMP_1 = 1
    ESC_INDEX = ESC_INDEX + ESC_TMP_1

    VEC_INPUT_B = AUX_read_mem(ESC_INDEX)
    ESC_TMP_1 = 1
    ESC_INDEX = ESC_INDEX + ESC_TMP_1

    if ESC_SELECTION == 0:
        sepia()
    elif ESC_SELECTION == 1:
        grey()
    elif ESC_SELECTION == 2:
        negative()

    ESC_TMP_1 = 3
    ESC_INDEX = ESC_INDEX - ESC_TMP_1

    AUX_write_mem(ESC_INDEX, VEC_RESULT_R)
    ESC_TMP_1 = 1
    ESC_INDEX = ESC_INDEX + ESC_TMP_1

    AUX_write_mem(ESC_INDEX, VEC_RESULT_G)
    ESC_TMP_1 = 1
    ESC_INDEX = ESC_INDEX + ESC_TMP_1

    AUX_write_mem(ESC_INDEX, VEC_RESULT_B)
    ESC_TMP_1 = 1
    ESC_INDEX = ESC_INDEX + ESC_TMP_1


# ================================= IGNORAR
(open("assets/mem_entrada.txt", "w+")).writelines(MEM_AUX)
# =================================
