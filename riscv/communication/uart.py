import serial
import time

try:
    ser = serial.Serial('COM4', 115000, timeout=1) # for some reason 115200 didn't work, it was slightly too fast
    print(f"Serial port {ser.name} opened successfully.")

    message = "Hello from Python!"
    # Encode into bytes and send
    ser.write(message.encode())
    print(f"Sent: '{message.strip()}'")

    response = ser.readline().decode().strip()
    print(f"Received: '{response}'")

except Exception as e:
    print(f"Error opening or communicating with serial port: {e}")

finally:
    if 'ser' in locals() and ser.is_open:
        ser.close()
        print("Serial port closed.")