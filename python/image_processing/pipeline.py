from post_process_img import post_process_image
from pre_process_img import pre_process_image
print("PRE PROCESSING ...")
pre_process_image("ex1_1.jpg", output_path="mem.txt")

print("MAIN ...")
exec(open('main.py').read())

print("POST PROCESSING ...")
post_process_image("mem.txt", width=450, height=800)
