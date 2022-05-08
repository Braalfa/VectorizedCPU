import ply.yacc as yacc

# Do not remove this import. PLY uses it to read tokens
from Lexer import tokens

# Result variable that will store the resulting tree
result = []


# Default code definition
def p_code(p):
    '''
    code : body
    '''


# A line body can be either an instruction or a label
def p_body(p):
    '''
    body : instruction body
         | label body
    '''
    p[0] = (p[1])


def p_empty(p):
    '''
    body :
    '''


# A label is of lexical type LABEL
def p_label(p):
    '''
    label : LABEL
    '''
    if p[1] != '$':
        p[0] = (p[1])
        result.append(p[0])
    else:
        p[0] = p[1]


# Instruction can be of five types
def p_instruction(p):
    '''
    instruction : spe_instr
                | ari_instr
                | reg_instr
                | mem_instr
                | bra_instr
    '''
    p[0] = p[1]


# Arithmetical instruction structure
def p_ari_instr(p):
    '''
    ari_instr : ari_instr_name REG COMMA REG COMMA REG
    '''
    if p[1] != '$':
        p[0] = (p[1], p[2], p[4], p[6])
        result.append(p[0])
    else:
        p[0] = p[1]


# Register instruction structure
def p_reg_instr(p):
    '''
    reg_instr : reg_instr_name REG COMMA REG COMMA REG
              | reg_instr_name REG COMMA REG
              | reg_instr_name REG COMMA IMM
              | reg_instr_name REG COMMA BIMM
              | reg_instr_name
    '''
    p_length = len(p)
    p[0] = (p[1],)
    if p_length > 2:
        # Case not empty
        p[0] += (p[2], p[4],)
    if p_length == 7:
        # Case REG REG
        p[0] += (p[6],)

    result.append(p[0])


# Memory instruction structure
def p_mem_instr(p):
    '''
    mem_instr : mem_instr_name REG COMMA REG
              | mem_instr_name REG
    '''
    p[0] = (p[1], p[2])
    if len(p) == 5:
        # Case REG REG
        p[0] += (p[4],)
    result.append(p[0])


# Branch instruction structure
def p_bra_instr(p):
    '''
    bra_instr : bra_instr_name LABEL
    '''
    p[0] = (p[1], p[2])
    result.append(p[0])


# Special instructions
def p_spe_instr(p):
    '''
    spe_instr : NOP
    '''
    p[0] = (p[1], '-')
    result.append(p[0])


# Arithmetic instruction names
def p_ari_instr_name(p):
    '''
    ari_instr_name : ADD
                   | SUB
                   | VADD
                   | VSUB
                   | VSMUL
    '''
    p[0] = p[1]


# Register instruction names
def p_reg_instr_name(p):
    '''
    reg_instr_name : MOVI
                   | CMP
                   | VMOVV
                   | VMOVI
                   | VCMPLT
                   | VCMPRST
    '''
    p[0] = p[1]


# Memory instruction names
def p_mem_instr_name(p):
    '''
    mem_instr_name : VSTR
                   | VLDR
                   | SLDR
                   | VOUT
    '''
    p[0] = p[1]


# Branch instruction names
def p_bra_instr_name(p):
    '''
    bra_instr_name : JMP
                   | BGE
                   | BE
    '''
    p[0] = p[1]


# Error case
def p_error(p):
    print("Syntax Error!")
    print("linea: " + str(p.lineno) + ' token: ' + str(p))


# Analyze the syntax of a string with above rules
def analyze_syntax(string):
    print("Analyzing syntax...")
    parser = yacc.yacc()
    parser.parse(string)

    return result[::-1]
