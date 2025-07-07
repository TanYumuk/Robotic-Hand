import serial
import cvzone
import cv2

ser = serial.Serial('COM5', 9600)
cap = cv2.VideoCapture(0)
detector = cvzone.HandDetector(maxHands=1, detectionCon=1)

while True:
    success, img = cap.read()
    img = detector.findHands(img)
    lmList, bbox = detector.findPosition(img)
    if lmList:
        fingers = detector.fingersUp()
        fingers.append(0)
        fingers.append(0)
        fingers.append(0)
        binary_byte = int(''.join(map(str, fingers)), 2)
        print(fingers)
        ser.write(bytes([binary_byte]))
    cv2.imshow("Image", img)
    cv2.waitKey(1)
ser.close()
