from pathlib import Path
from instructions_map import build_instruction

current_dir = Path(__file__).parent

def parse_file(file_path):
    try:
        with open(file_path, 'r') as read_file:
            content = read_file.read()
    except Exception as e:
        print(f"Error reading file {file_path}: {e}")
        return None

    lines = content.splitlines()

    write_path = current_dir / 'instructions.mem'

    with open(write_path, 'w') as write_file:
        for line in lines:
            if line.startswith('#') or not line.strip():
                continue
            try:
                instruction = build_instruction(line.strip())
                if instruction:
                    hex_instruction = format(int(instruction, 2), 'x')
                    write_file.write(hex_instruction + '\n')
                else:
                    print(f"Invalid instruction format: {line}")
            except Exception as e:
                print(f"Error parsing line '{line}': {e}")

def main():
    file_path = current_dir / 'instructions.as'
    if not file_path.exists():
        print(f"File {file_path} does not exist.")
        return
    parse_file(file_path)

if __name__ == "__main__":
    main()