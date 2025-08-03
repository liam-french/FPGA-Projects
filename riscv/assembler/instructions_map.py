import re

# Instruction format definitions
r_fmt = {
    "ADD":  {"opcode": "0110011", "funct3": "000", "funct7": "0000000"},
    "SUB":  {"opcode": "0110011", "funct3": "000", "funct7": "0100000"},
    "SLL":  {"opcode": "0110011", "funct3": "001", "funct7": "0000000"},
    "SLT":  {"opcode": "0110011", "funct3": "010", "funct7": "0000000"},
    "SLTU": {"opcode": "0110011", "funct3": "011", "funct7": "0000000"},
    "XOR":  {"opcode": "0110011", "funct3": "100", "funct7": "0000000"},
    "SRL":  {"opcode": "0110011", "funct3": "101", "funct7": "0000000"},
    "SRA":  {"opcode": "0110011", "funct3": "101", "funct7": "0100000"},
    "OR":   {"opcode": "0110011", "funct3": "110", "funct7": "0000000"},
    "AND":  {"opcode": "0110011", "funct3": "111", "funct7": "0000000"},
}

i_fmt = {
    "ADDI":  {"opcode": "0010011", "funct3": "000"},
    "SLTI":  {"opcode": "0010011", "funct3": "010"},
    "SLTIU": {"opcode": "0010011", "funct3": "011"},
    "SLLI":  {"opcode": "0010011", "funct3": "001", "funct7": "0000000"},
    "SRLI":  {"opcode": "0010011", "funct3": "101", "funct7": "0000000"},
    "SRAI":  {"opcode": "0010011", "funct3": "101", "funct7": "0100000"},
    "XORI":  {"opcode": "0010011", "funct3": "100"},
    "ORI":   {"opcode": "0010011", "funct3": "110"},
    "ANDI":  {"opcode": "0010011", "funct3": "111"},
    "LB":    {"opcode": "0000011", "funct3": "000"},
    "LH":    {"opcode": "0000011", "funct3": "001"},
    "LW":    {"opcode": "0000011", "funct3": "010"},
}

s_fmt = {
    "SB": {"opcode": "0100011", "funct3": "000"},
    "SH": {"opcode": "0100011", "funct3": "001"},
    "SW": {"opcode": "0100011", "funct3": "010"},
}

sb_fmt = {
    "BEQ":  {"opcode": "1100011", "funct3": "000"},
    "BNE":  {"opcode": "1100011", "funct3": "001"},
    "BLT":  {"opcode": "1100011", "funct3": "100"},
    "BGE":  {"opcode": "1100011", "funct3": "101"},
    "BLTU": {"opcode": "1100011", "funct3": "110"},
    "BGEU": {"opcode": "1100011", "funct3": "111"},
}

u_fmt = {
    "LUI":   {"opcode": "0110111"},
    "AUIPC": {"opcode": "0010111"},
}

uj_fmt = {
    "JAL": {"opcode": "1101111"},
}

# Merge all instruction formats
instructions = {**r_fmt, **i_fmt, **s_fmt, **sb_fmt, **u_fmt, **uj_fmt}

# Utility functions
def get_instruction_by_name(name):
    return instructions.get(name.upper())

def get_instruction_type(name):
    name = name.upper()
    if name in r_fmt:
        return "R"
    if name in i_fmt:
        return "I"
    if name in s_fmt:
        return "S"
    if name in sb_fmt:
        return "SB"
    if name in u_fmt:
        return "U"
    if name in uj_fmt:
        return "UJ"
    print(f"Unknown instruction type for: {name}")
    return None

def get_instruction_opcode(name):
    instr = get_instruction_by_name(name)
    return instr.get("opcode") if instr else None

def get_instruction_funct3(name):
    instr = get_instruction_by_name(name)
    return instr.get("funct3") if instr else None

def get_instruction_funct7(name):
    instr = get_instruction_by_name(name)
    return instr.get("funct7") if instr else None

def register_to_binary(reg):
    if reg.lower().startswith("x"):
        val = int(reg[1:])
        if 0 <= val <= 31:
            return f"{val:05b}"
    raise ValueError(f"Invalid register: {reg}")

def parse_instruction(instr_str):
    parts = instr_str.replace(",", "").split()
    if not parts:
        return None
    name = parts[0].upper()
    fmt = get_instruction_type(name)
    if not fmt:
        return None

    args = parts[1:]
    result = {"name": name}

    try:
        if fmt == "R" and len(args) == 3:
            result.update({
                "rd": register_to_binary(args[0]),
                "rs1": register_to_binary(args[1]),
                "rs2": register_to_binary(args[2])
            })
        elif fmt == "I" and len(args) >= 2:
            result["rd"] = register_to_binary(args[0])
            if "(" in args[1]:
                match = re.match(r"(-?\d+)\((x\d+)\)", args[1])
                if not match:
                    return None
                imm, rs1 = match.groups()
                result.update({
                    "rs1": register_to_binary(rs1),
                    "imm": imm
                })
            else:
                result.update({
                    "rs1": register_to_binary(args[1]),
                    "imm": args[2]
                })
        elif fmt == "S" and len(args) in [2, 3]:
            result["rs2"] = register_to_binary(args[0])
            if "(" in args[1]:
                match = re.match(r"(-?\d+)\((x\d+)\)", args[1])
                if not match:
                    return None
                imm, rs1 = match.groups()
                result.update({
                    "rs1": register_to_binary(rs1),
                    "imm": imm
                })
            else:
                result.update({
                    "rs2": register_to_binary(args[0]),
                    "rs1": register_to_binary(args[1]),
                    "imm": args[2]
                })
        elif fmt == "SB" and len(args) == 3:
            result.update({
                "rs1": register_to_binary(args[0]),
                "rs2": register_to_binary(args[1]),
                "imm": args[2]
            })
        elif fmt in ["U", "UJ"] and len(args) == 2:
            result.update({
                "rd": register_to_binary(args[0]),
                "imm": args[1]
            })
        else:
            return None
    except Exception:
        return None

    return result

def build_instruction(instruction_str):
    parsed = parse_instruction(instruction_str)
    if not parsed:
        raise ValueError(f"Invalid instruction format: {instruction_str}")
    name = parsed["name"]
    rd = parsed.get("rd", "00000")
    rs1 = parsed.get("rs1", "00000")
    rs2 = parsed.get("rs2", "00000")
    imm = parsed.get("imm", None)
    fmt = get_instruction_type(name)
    instr = get_instruction_by_name(name)

    if not instr or not fmt:
        raise ValueError(f"Invalid instruction: {name}")

    opcode = instr.get("opcode")
    funct3 = instr.get("funct3", "000")
    funct7 = instr.get("funct7", "0000000")

    if fmt == "R":
        return f"{funct7}{rs2}{rs1}{funct3}{rd}{opcode}"
    if imm is None:
        raise ValueError("Immediate value (imm) must not be None for non R-type instructions")
    if fmt == "I":
        if imm is None:
            raise ValueError("Immediate value (imm) must not be None for I-type instructions")
        imm_bin = f"{int(imm) & 0xFFF:012b}"
        return f"{imm_bin}{rs1}{funct3}{rd}{opcode}"
    if fmt == "S":
        imm_bin = f"{int(imm) & 0xFFF:012b}"
        return f"{imm_bin[:7]}{rs2}{rs1}{funct3}{imm_bin[7:]}{opcode}"
    if fmt == "SB":
        imm_val = int(imm)
        imm12   = (imm_val >> 12) & 0x1
        imm10_5 = (imm_val >> 5) & 0x3F
        imm4_1  = (imm_val >> 1) & 0xF
        imm11   = (imm_val >> 11) & 0x1
        return f"{imm12:01b}{imm10_5:06b}{rs2}{rs1}{funct3}{imm4_1:04b}{imm11:01b}{opcode}"
    if fmt == "U":
        return f"{int(imm) & 0xFFFFF:020b}{rd}{opcode}"
    if fmt == "UJ":
        imm_val = int(imm)
        imm20   = (imm_val >> 20) & 0x1
        imm10_1 = (imm_val >> 1) & 0x3FF
        imm11   = (imm_val >> 11) & 0x1
        imm19_12 = (imm_val >> 12) & 0xFF
        return f"{imm20:01b}{imm10_1:010b}{imm11:01b}{imm19_12:08b}{rd}{opcode}"

    raise ValueError(f"Unsupported format: {fmt}")
