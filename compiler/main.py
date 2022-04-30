from compiler import Compiler

# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    # Open source file
    file = open("code.txt", "r", encoding="utf-8")
    string = file.read()
    file.close()

    # Compile stuff
    Compiler.compile_code(string)
