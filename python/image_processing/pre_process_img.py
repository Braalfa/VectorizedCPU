from PIL import Image
import numpy as np

# ======================================================
# =========================WRITE========================
# ======================================================


def pre_process_image(image, output_path="output.txt"):
    image = Image.open(image)

    data = np.array(image)

    print("IMAGE SIZE", data.shape)

    dif = (data.shape[0] * data.shape[1]) % 6
    if dif == 0:
        print("DIVISIBLE 6", (data.shape[0] * data.shape[1]))
    else:
        print("NO DIVISIBLE 6, ADJUSTING LINES ...")
        print("OLD SHAPE:", data.shape)
        data = data[:data.shape[0]-dif, :, :]
        print("NEW SHAPE:", data.shape)

    r_vals = data[:, :, 0]
    g_vals = data[:, :, 1]
    b_vals = data[:, :, 2]

    r_vals_reshaped = r_vals.reshape((-1, 6))
    g_vals_reshaped = g_vals.reshape((-1, 6))
    b_vals_reshaped = b_vals.reshape((-1, 6))

    txt = ""
    for r_row, g_row, b_row in zip(r_vals_reshaped, g_vals_reshaped, b_vals_reshaped):
        txt += ("".join(["{:08b}".format(x) for x in r_row]))+"\n"
        txt += ("".join(["{:08b}".format(x) for x in g_row]))+"\n"
        txt += ("".join(["{:08b}".format(x) for x in b_row]))+"\n"
    # print(txt)

    txt += "1"*8*6

    f = open(output_path, "w+")
    f.write(txt)


#pre_process_image("ex1.jpg", output_path="mem_aux.txt")
if (__name__ == "__main__"):
    pre_process_image("assets/test/ex1_256.jpg", output_path="../../microarquitectura/Memory/data.txt")
