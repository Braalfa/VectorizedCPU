from PIL import Image
import numpy as np

# ======================================================
# =========================READ=========================
# ======================================================


def post_process_image(file_txt, width=6, height=6, output_file=""):
    f = open(file_txt)
    txt = f.read()
    txt = txt.replace("\n", "")

    r_vals_read = []
    g_vals_read = []
    b_vals_read = []

    WIDTH = 8
    i = 0
    while i + WIDTH*6 < len(txt):
        for j in range(6):
            r_vals_read.append(txt[i:i+WIDTH])
            i += WIDTH
        for j in range(6):
            g_vals_read.append(txt[i:i+WIDTH])
            i += WIDTH
        for j in range(6):
            b_vals_read.append(txt[i:i+WIDTH])
            i += WIDTH

    r_vals_read = [min(int(x, base=2), 255) for x in r_vals_read]
    g_vals_read = [min(int(x, base=2), 255) for x in g_vals_read]
    b_vals_read = [min(int(x, base=2), 255) for x in b_vals_read]

    # print(r_vals_read, g_vals_read, b_vals_read)

    image_data = np.dstack((r_vals_read, g_vals_read, b_vals_read))
    current_pixels = (image_data.shape[1])
    if width*height == current_pixels:
        image_data = image_data.reshape((width, height, 3))
    else:
        dif = width*height - current_pixels
        print(
            f"FILLING WITH ZEROS, image desired size: {width}x{height}={width*height}, current size: {current_pixels}")
        print(current_pixels, dif)
        image_data = np.concatenate(
            (image_data, np.zeros((1, dif, 3))), axis=1)
        print(image_data.shape, width*height)

        image_data = image_data.reshape((width, height, 3))
        image_data = image_data[:int(height-dif/width),:,:]

        # print(data == new_data)

    image2 = Image.fromarray(image_data.astype(np.uint8))
    image2.save(output_file)

if (__name__ == "__main__"):
    post_process_image("../../microarquitectura/outFile.img", width=256,
                       height=256, output_file="assets/mem_salida.jpg")
