from main import *

# ================================= PRUEBAS


def test():
    global VEC_INPUT_R, VEC_INPUT_G, VEC_INPUT_B, VEC_RESULT_R, VEC_RESULT_G, VEC_RESULT_B

    VEC_INPUT_R = np.full((6,), 150)
    VEC_INPUT_G = np.full((6,), 100)
    VEC_INPUT_B = np.full((6,), 150)

    sepia()
    print("COMPROBACIÓN".center(50, "="))
    print(VEC_INPUT_R*.393+VEC_INPUT_G*.769+VEC_INPUT_B*.189 == VEC_RESULT_R)
    print(VEC_INPUT_R*.349+VEC_INPUT_G*.686+VEC_INPUT_B*.168 == VEC_RESULT_G)
    print(VEC_INPUT_R*.272+VEC_INPUT_G*.534+VEC_INPUT_B*.131 == VEC_RESULT_B)

    grey()
    print("COMPROBACIÓN".center(50, "="))
    print(VEC_INPUT_R*.3+VEC_INPUT_G*.59+VEC_INPUT_B*.11 == VEC_RESULT_R)
    print(VEC_INPUT_R*.3+VEC_INPUT_G*.59+VEC_INPUT_B*.11 == VEC_RESULT_G)
    print(VEC_INPUT_R*.3+VEC_INPUT_G*.59+VEC_INPUT_B*.11 == VEC_RESULT_B)

    negative()
    print("COMPROBACIÓN".center(50, "="))
    print(255-VEC_INPUT_R == VEC_RESULT_R)
    print(255-VEC_INPUT_R == VEC_RESULT_G)
    print(255-VEC_INPUT_R == VEC_RESULT_B)
# =================================


test()
