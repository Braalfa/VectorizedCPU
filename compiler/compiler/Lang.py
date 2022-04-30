# Available registers
registers = {
    'R0': '000',
    'R1': '001',
    'R2': '010',
    'R3': '011',
    'V0': '000',
    'V1': '001',
    'V2': '010',
    'V3': '011',
    'V4': '100',
    'V5': '101',
    'V6': '110',
}

# Arithmetic type instructions
ari_instrs = {
    'VADD': int('00100', 2),
    'VSUB': int('00101', 2),
    'VSMUL': int('00110', 2),
    'ADD': int('01010', 2),
    'SUB': int('01011', 2),
}

# Register type instructions
reg_instrs = {
    'VMOVV': int('00111', 2),
    'VMOVI': int('01000', 2),
    'MOVI': int('01100', 2),
    'CMP': int('01101', 2),
    'VCMPLT': int('10001', 2),
    'VCMPRST': int('10010', 2),
}

# Memory type instructions
mem_instrs = {
    'VSTR': int('00001', 2),
    'VLDR': int('00010', 2),
    'SLDR': int('00011', 2),
    'VOUT': int('01001', 2),
}

# Branch type instructions
bra_instrs = {
    'BGE': int('01110', 2),
    'BE': int('01111', 2),
    'JMP': int('10000', 2),
}

# Special type instructions
spe_instrs = {
    'NOP': int('00000', 2)
}
