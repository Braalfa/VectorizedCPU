SELECTION = 1

INPUT_R = 150
INPUT_G = 100
INPUT_B = 150

RESULT_R = 0
RESULT_G = 0
RESULT_B = 0

TMP_1 = 0
TMP_2 = 0


def sepia():
    global INPUT_R, INPUT_G, INPUT_B, RESULT_R, RESULT_G, RESULT_B

    # outputRed = (inputRed × 0,393) + (inputGreen × 0,769) + (inputBlue × 0,189)
    RESULT_R = 0

    TMP_1 = 393
    TMP_1 = TMP_1 * INPUT_R
    RESULT_R = RESULT_R + TMP_1

    TMP_1 = 769
    TMP_1 = TMP_1 * INPUT_G
    RESULT_R = RESULT_R + TMP_1

    TMP_1 = 189
    TMP_1 = TMP_1 * INPUT_B
    RESULT_R = RESULT_R + TMP_1

    # outputGreen = (inputRed × 0,349) + (inputGreen × 0,686) + (inputBlue × 0,168)
    RESULT_G = 0

    TMP_1 = 349
    TMP_1 = TMP_1 * INPUT_R
    RESULT_G = RESULT_G + TMP_1

    TMP_1 = 686
    TMP_1 = TMP_1 * INPUT_G
    RESULT_G = RESULT_G + TMP_1

    TMP_1 = 168
    TMP_1 = TMP_1 * INPUT_B
    RESULT_G = RESULT_G + TMP_1

    # outputBlue = (inputRed × 0,272) + (inputGreen × 0,534) + (inputBlue × 0,131)
    RESULT_B = 0

    TMP_1 = 272
    TMP_1 = TMP_1 * INPUT_R
    RESULT_B = RESULT_B + TMP_1

    TMP_1 = 534
    TMP_1 = TMP_1 * INPUT_G
    RESULT_B = RESULT_B + TMP_1

    TMP_1 = 131
    TMP_1 = TMP_1 * INPUT_B
    RESULT_B = RESULT_B + TMP_1


def grey():
    global INPUT_R, INPUT_G, INPUT_B, RESULT_R, RESULT_G, RESULT_B

    # luminisity method
    # https://www.baeldung.com/cs/convert-rgb-to-grayscale#3-luminosity-method

    TMP_1 = 300
    TMP_1 = TMP_1 * INPUT_R
    RESULT_R = RESULT_R + TMP_1

    TMP_1 = 590
    TMP_1 = TMP_1 * INPUT_G
    RESULT_R = RESULT_R + TMP_1

    TMP_1 = 110
    TMP_1 = TMP_1 * INPUT_B
    RESULT_R = RESULT_R + TMP_1

    RESULT_G = RESULT_R
    RESULT_B = RESULT_R


def negative():
    global INPUT_R, INPUT_G, INPUT_B, RESULT_R, RESULT_G, RESULT_B

    TMP_1 = 1000
    TMP_1 = INPUT_R * TMP_1
    RESULT_R = 255000
    RESULT_R = RESULT_R - TMP_1

    TMP_1 = 1000
    TMP_1 = INPUT_G * TMP_1
    RESULT_G = 255000
    RESULT_G = RESULT_G - TMP_1

    TMP_1 = 1000
    TMP_1 = INPUT_B * TMP_1
    RESULT_B = 255000
    RESULT_B = RESULT_B - TMP_1


# ____________________________/ NOTAS
# 3 decimales + 3 digitos -> 6 digitos dec -> 20bits
# maxima multiplciacion: 255' x 1'000 =  255'000 -> 18bits


SELECTION = 3

if (SELECTION == 1):
    sepia()

    # PRUEBAS
    print("OBTENIDO".center(50, "="))
    print(RESULT_R/1000)
    print(RESULT_G/1000)
    print(RESULT_B/1000)
    print("ESPERADO".center(50, "="))
    print(INPUT_R*.393+INPUT_G*.769+INPUT_B*.189)
    print(INPUT_R*.349+INPUT_G*.686+INPUT_B*.168)
    print(INPUT_R*.272+INPUT_G*.534+INPUT_B*.131)

if (SELECTION == 2):
    grey()

    # PRUEBAS
    print("OBTENIDO".center(50, "="))
    print(RESULT_R/1000)
    print(RESULT_G/1000)
    print(RESULT_B/1000)
    print("ESPERADO".center(50, "="))
    print(INPUT_R*.3+INPUT_G*.59+INPUT_B*.11)
    print(INPUT_R*.3+INPUT_G*.59+INPUT_B*.11)
    print(INPUT_R*.3+INPUT_G*.59+INPUT_B*.11)

if (SELECTION == 3):
    negative()

    # PRUEBAS
    print("OBTENIDO".center(50, "="))
    print(RESULT_R/1000)
    print(RESULT_G/1000)
    print(RESULT_B/1000)
    print("ESPERADO".center(50, "="))
    print(255-INPUT_R)
    print(255-INPUT_G)
    print(255-INPUT_B)
