import os

def list_sv_files():
    current_dir = os.path.dirname(os.path.abspath(__file__))
    sv_files = [f for f in os.listdir(current_dir) if f.endswith('.sv')]

    for index, sv_file in enumerate(sv_files):
        print(f"[{index + 1}] -- {sv_file}")
    
    return sv_files

def main():
    while True:
        os.system('cls')

        print("\n----- RISC-V Core Testbenches -----")
        sv_files = list_sv_files()

        print("\nSelect a testbench to run (or 'q' to quit):")
        
        choice = input(">>> ").strip()
        
        if choice.lower() == 'q':
            print("Exiting...")
            break

        if choice.isdigit():
            choice = int(choice)
        else:
            continue

        if 1 <= choice <= len(sv_files):
            gui = input("Do you want to run the testbench in GUI mode? (y/n): ").strip().lower()

            selected_file = sv_files[choice - 1]
            print(f"Running testbench: {selected_file}")

            os.system("vlog -sv +acc=rn ../*.sv ../*.vh")
            os.system(f"vlog {selected_file}")

            tb_name = os.path.splitext(selected_file)[0]
            if gui == 'y':
                os.system(f"vsim work.{tb_name} -do \"run -all;\"")
            else:
                os.system(f"vsim -c work.{tb_name} -do \"run -all; quit\"")
            break

if __name__ == "__main__":
    main()