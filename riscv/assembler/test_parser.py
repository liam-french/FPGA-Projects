# type: ignore
import pytest

from instructions_map import (
    get_instruction_by_name,
    get_instruction_type,
    get_instruction_opcode,
    get_instruction_funct3,
    get_instruction_funct7,
    register_to_binary,
    parse_instruction,
    build_instruction,
)

def test_get_instruction_by_name():
    assert get_instruction_by_name("add").get("opcode") == "0110011"
    assert get_instruction_by_name("lw").get("opcode") == "0000011"
    assert get_instruction_by_name("invalid") is None

def test_get_instruction_type():
    assert get_instruction_type("add") == "R"
    assert get_instruction_type("addi") == "I"
    assert get_instruction_type("sw") == "S"
    assert get_instruction_type("beq") == "SB"
    assert get_instruction_type("lui") == "U"
    assert get_instruction_type("jal") == "UJ"
    assert get_instruction_type("invalid") is None

def test_get_instruction_opcode():
    assert get_instruction_opcode("add") == "0110011"
    assert get_instruction_opcode("jal") == "1101111"
    assert get_instruction_opcode("invalid") is None

def test_get_instruction_funct3():
    assert get_instruction_funct3("add") == "000"
    assert get_instruction_funct3("jal") is None

def test_get_instruction_funct7():
    assert get_instruction_funct7("add") == "0000000"
    assert get_instruction_funct7("jal") is None

@pytest.mark.parametrize("reg,expected", [
    ("x0", "00000"),
    ("x1", "00001"),
    ("x31", "11111"),
])
def test_register_to_binary_valid(reg, expected):
    assert register_to_binary(reg) == expected

@pytest.mark.parametrize("reg", ["x32", "x-1", "y0", "0"])
def test_register_to_binary_invalid(reg):
    with pytest.raises(ValueError):
        register_to_binary(reg)

def test_parse_instruction_r_type():
    result = parse_instruction("ADD x1, x2, x3")
    assert result["name"] == "ADD"
    assert result["rd"] == "00001"
    assert result["rs1"] == "00010"
    assert result["rs2"] == "00011"

def test_parse_instruction_i_type():
    result = parse_instruction("ADDI x1, x2, 10")
    assert result["name"] == "ADDI"
    assert result["rd"] == "00001"
    assert result["rs1"] == "00010"
    assert result["imm"] == "10"

def test_parse_instruction_i_type_load():
    result = parse_instruction("LW x1, 4(x2)")
    assert result["name"] == "LW"
    assert result["rd"] == "00001"
    assert result["rs1"] == "00010"
    assert result["imm"] == "4"

def test_parse_instruction_s_type():
    result = parse_instruction("SW x1, x2, 8")
    assert result["name"] == "SW"
    assert result["rs2"] == "00001"
    assert result["rs1"] == "00010"
    assert result["imm"] == "8"

def test_parse_instruction_sb_type():
    result = parse_instruction("BEQ x1, x2, 12")
    assert result["name"] == "BEQ"
    assert result["rs1"] == "00001"
    assert result["rs2"] == "00010"
    assert result["imm"] == "12"

def test_parse_instruction_u_type():
    result = parse_instruction("LUI x1, 1000")
    assert result["name"] == "LUI"
    assert result["rd"] == "00001"
    assert result["imm"] == "1000"

def test_parse_instruction_uj_type():
    result = parse_instruction("JAL x1, 2048")
    assert result["name"] == "JAL"
    assert result["rd"] == "00001"
    assert result["imm"] == "2048"

def test_parse_instruction_invalid():
    assert parse_instruction("") is None
    assert parse_instruction("INVALID x1, x2, x3") is None
    assert parse_instruction("ADD x1, x2") is None

def test_build_instruction_r_type():
    # ADD x1, x2, x3: funct7(0000000) rs2(00011) rs1(00010) funct3(000) rd(00001) opcode(0110011)
    instr = build_instruction("ADD x1, x2, x3")
    assert instr == "00000000001100010000000010110011"

def test_build_instruction_i_type():
    # ADDI x1, x2, 5: imm(000000000101) rs1(00010) funct3(000) rd(00001) opcode(0010011)
    instr = build_instruction("ADDI x1, x2, 5")
    assert instr == "00000000010100010000000010010011"

def test_build_instruction_i_type_offset():
    # LW x1, 4(x2): imm(000000000100) rs1(00010) funct3(010) rd(00001) opcode(0000011)
    instr = build_instruction("LW x1, 4(x2)")
    assert instr == "00000000010000010010000010000011"

def test_build_instruction_s_type():
    # SW x1, x2, 8: imm[11:5](0000000) rs2(00001) rs1(00010) funct3(010) imm[4:0](01000) opcode(0100011)
    instr = build_instruction("SW x1, x2, 8")
    assert instr == "00000000000100010010010000100011"

def test_build_instruction_s_type_offset():
    # SW x1, 8(x2): imm[11:5](0000000) rs2(00001) rs1(00010) funct3(010) imm[4:0](01000) opcode(0100011)
    instr = build_instruction("SW x1, 8(x2)")
    assert instr == "00000000000100010010010000100011"

def test_build_instruction_u_type():
    # LUI x1, 4096: imm(00000001000000000000) rd(00001) opcode(0110111)
    instr = build_instruction("LUI x1, 4096")
    assert instr == "00000001000000000000000010110111"

def test_build_instruction_uj_type():
    # JAL x1, 2048: check correct binary length and opcode
    instr = build_instruction("JAL x1, 2048")
    assert instr.endswith("00001" + "1101111")
    assert len(instr) == 32

def test_build_instruction_invalid():
    with pytest.raises(ValueError):
        build_instruction("INVALID x1, x2, x3")
    with pytest.raises(ValueError):
        build_instruction("ADD x1, x2")  # Not enough args
    with pytest.raises(ValueError):
        build_instruction("ADDI x1, x2")  # Not enough args