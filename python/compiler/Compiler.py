import Lang

from Lexer import analyze_lexical
from Syntaxer import analyze_syntax

# Variables for compilation
bra_labels = {}

hex_instr = []
bin_instr = []

# Useful constants
three_0s = '000'
sixteen_0s = '0000000000000000'
nineteen_0s = '0000000000000000000'


# Compile a block of code using the Spasm language lexemes and syntax
def compile_code(code):
    # Lexical and syntax analysis
    analyze_lexical(code)

    result_tree = analyze_syntax(code)
    result_tree.reverse()

    print("Result tree:")
    print(result_tree)

    # Get all labels and their line position in code
    p_dir = 0
    for ele in result_tree:
        if isinstance(ele, tuple):
            p_dir += 1
        else:
            bra_labels.update({ele: hex(p_dir)})

    print("Branch labels:")
    print(bra_labels)

    # Convert each instruction using language definition in binary form
    tree_to_bin(result_tree)

    print(bin_instr)

    # Write on file
    write_instr()


# Convert each instruction using language definition in binary form
def tree_to_bin(tree):
    p_dir = 0
    hex_dir_list = []
    instr_list = []
    for ele in tree:
        if isinstance(ele, tuple):
            hex_dir = hex(p_dir)
            hex_dir_list.append(hex_dir)

            instr_list.append(ele)
            analyze_instr(ele, hex_dir)
            p_dir += 1


# Writes instructions in bin form on an output txt file
def write_instr():
    with open("../../microarquitectura/Fetch/compiledInstructions.txt", "w") as file:
        for instr in bin_instr:
            file.write("%s\n" % instr)


# Analyze instructions and convert to corresponding op code for processor
def analyze_instr(instr, p_dir):
    print("ANALYZING")
    print("instruction: " + str(instr) + " on line " + str(int(p_dir, 16)))

    bin_res = ''
    instr_str = instr[0]
    # Detect in which category the instruction label falls
    if instr_str in Lang.ari_instrs:
        bin_res = analyze_instr_ari(instr)
    elif instr_str in Lang.reg_instrs:
        bin_res = analyze_instr_reg(instr)
    elif instr_str in Lang.mem_instrs:
        bin_res = analyze_instr_mem(instr)
    elif instr_str in Lang.bra_instrs:
        bin_res = analyze_instr_bra(instr)
    elif instr_str in Lang.spe_instrs:
        bin_res = analyze_instr_spe(instr)
    else:
        print("Instruction " + instr + " unrecognized")

    # Append binary result of instruction to list
    bin_instr.append(bin_res)
    print("Instruction added")


# Analyzes arithmetical instructions and adds 30 bit binary number to list
def analyze_instr_ari(instr):
    bin_code = str(format(Lang.ari_instrs.get(instr[0]), '#010b'))[5:]

    print("op code for " + instr[0] + " is " + bin_code)

    # Arithmetical instruction is REG REG REG
    # Get data
    r1 = Lang.registers.get(str(instr[1]))
    r2 = Lang.registers.get(str(instr[2]))
    r3 = Lang.registers.get(str(instr[3]))

    print("registers are " + r1 + " " + r2 + " " + r3)

    # Append data
    bin_code += r1
    bin_code += r2
    bin_code += r3
    bin_code += sixteen_0s

    print("binary: " + bin_code)
    print("length: " + str(len(bin_code)))

    return bin_code


# Analyzes register type instructions and adds 30 bit binary number to list
def analyze_instr_reg(instr):
    bin_code = str(format(Lang.reg_instrs.get(instr[0]), '#010b'))[5:]

    print("op code for " + instr[0] + " is " + bin_code)

    if len(instr) == 1:
        # Instruction doesn't have arguments
        bin_code += three_0s
        bin_code += three_0s
        bin_code += nineteen_0s
    elif isinstance(instr[2], int) or instr[2][0] == "b":
        # Register instruction is REG IMM
        # Get data
        imm = instr[2]
        if not isinstance(instr[2], int):
            # Binary inmediate
            imm = int(imm[1:], 2)
            print("int binary inmediate is " + str(imm))

        imm = shift_num(bin(imm)[2:], 19)
        r1 = Lang.registers.get(str(instr[1]))

        print("imm is " + imm)
        print("reg is " + r1)

        # Append data
        bin_code += r1
        bin_code += three_0s
        bin_code += imm
    else:
        # Register instruction is REG REG REG or REG REG
        r1 = Lang.registers.get(str(instr[1]))
        r2 = Lang.registers.get(str(instr[2]))

        if len(instr) > 3:
            # REG REG REG - Get third REG
            r3 = Lang.registers.get(str(instr[3]))
            print("registers are " + r1 + " " + r2 + " " + r3)

            # Append data
            bin_code += r1
            bin_code += r2
            bin_code += r3
            bin_code += sixteen_0s
        else:
            # REG REG - Only has two REGs
            print("registers are " + r1 + " " + r2)

            if instr[0] == "VMOVV":
                # VMOVV with two REGs special case
                # Append data
                bin_code += r1
                bin_code += three_0s
                bin_code += r2
                bin_code += sixteen_0s
            else:
                # Append data
                bin_code += three_0s
                bin_code += r1
                bin_code += r2
                bin_code += sixteen_0s

    print("binary: " + bin_code)
    print("length: " + str(len(bin_code)))

    return bin_code


# Analyzes memory instructions and adds 30 bit binary number to list
def analyze_instr_mem(instr):
    bin_code = str(format(Lang.mem_instrs.get(instr[0]), '#010b'))[5:]

    print("op code for " + instr[0] + " is " + bin_code)

    # Get data
    r1 = Lang.registers.get(str(instr[1]))

    print("r1 is " + r1)

    if len(instr) < 3:
        # Case REG
        bin_code += three_0s
        bin_code += r1
        bin_code += nineteen_0s
    else:
        # Case REG REG
        r2 = Lang.registers.get(str(instr[2]))

        print("r2 is " + r2)
        if instr[0] == "VSTR":
            # Special VSTR case order
            bin_code += three_0s
            bin_code += r1
            bin_code += r2
            bin_code += sixteen_0s
        else:
            # Append data
            bin_code += r1
            bin_code += r2
            bin_code += nineteen_0s

    print("binary: " + bin_code)
    print("length: " + str(len(bin_code)))

    return bin_code


# Analyzes branch instructions and adds 30 bit binary number to list
def analyze_instr_bra(instr):
    bin_code = ''

    bra_op_code = str(format(Lang.bra_instrs.get(instr[0]), '#010b'))[5:]
    print("op code for " + instr[0] + " is " + bra_op_code)

    target = str(instr[1])

    # Verify that label exists
    if target in bra_labels:
        # Label exists
        bra_dir = bin(int(bra_labels.get(instr[1]), 16))[2:]

        print("branch to direction " + bra_dir)

        # Append data
        bin_code += bra_op_code
        bin_code += shift_num(bra_dir, 25)
    else:
        # Label doesn't exist
        print("target branch " + str(instr[1]) + " does not exist")

    print("binary: " + bin_code)
    print("length: " + str(len(bin_code)))

    return bin_code


# Analyzes special instructions and adds 30 bit binary number to list
def analyze_instr_spe(instr):
    bin_code = ''
    bin_code += str(format(Lang.spe_instrs.get(instr[0]), '#010b'))[5:]

    print("op code for " + instr[0] + " is " + bin_code)

    # Append data
    bin_code += nineteen_0s
    bin_code += three_0s
    bin_code += three_0s

    print("binary: " + bin_code)
    print("length: " + str(len(bin_code)))

    return bin_code


# Shifts a string number by adding 0s to its left
def shift_num(num, shift):
    num_len = len(num)

    if num_len < shift:
        while num_len < shift:
            num = '0' + num
            num_len += 1

    return num
