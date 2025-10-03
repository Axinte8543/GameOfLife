# minimum required version python3.7
import os
import subprocess

inputArray = [
          ["test0_0.in", "test0_1.in", "test0_2.in", "test0_3.in", "test0_4.in"],
          ["test0_0.in", "test0_1.in", "test0_2.in", "test0_3.in", "test0_4.in"]
]
outputArray = [
          ["1 ", "1 1 1 0 0 1 1 1 ", "0 0 0 0 0 1 1 1 0 0 1 0 1 0 0 1 0 0 1 0 1 0 0 0 0 1 1 0 0 0 0 0 0 0 0 ",
           "1 1 1 0 1 1 0 1 0 0 0 1 0 0 1 1 0 1 0 1 0 1 1 0 ",
           "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 1 0 0 1 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 "],
          ["1 ", "1 1 1 0 0 1 1 1 ", "0 0 0 0 0 1 1 1 0 0 1 0 1 0 0 1 0 0 1 0 1 0 0 0 0 1 1 0 0 0 0 0 0 0 0 ",
           "1 1 1 0 1 1 0 1 0 0 0 1 0 0 1 1 0 1 0 1 0 1 1 0 ",
           "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 1 0 0 1 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 "]
]
points = [
          [10, 10, 10, 10, 10],
          [5, 5, 5, 5, 5]
]


for file in os.listdir('.'):
    if os.path.isfile(file) and (file.endswith(".s") or file.endswith(".S")):
        print(file)
        subprocess.call(["gcc", "-m32", "-no-pie", file, "-o", "cerinta" + file[-3]])

# doar cerinta0 și cerinta2
executables = ["./cerinta0", "./cerinta2"]

estimatedGrade = 0

for taskIndex in range(len(executables)):
    findResult = subprocess.call(["find", executables[taskIndex]], stdout=subprocess.DEVNULL,
                                  stderr=subprocess.STDOUT)
    if findResult:
        print("Executable %s not found!" % executables[taskIndex])
        continue

    print("Task " + str(taskIndex) + ":")

    taskInputArray = inputArray[taskIndex]
    taskOutputArray = outputArray[taskIndex]
    taskPoints = points[taskIndex]

    for i in range(len(taskInputArray)):
        try:
            inputFile = open(taskInputArray[i])
            captureOutput = True
            if taskIndex == 1:   # aici taskIndex==1 corespunde lui cerinta2
                subprocess.run(["cp", taskInputArray[i], "in.txt"])
                captureOutput = False
            result = subprocess.run([executables[taskIndex]], shell=True, timeout=10,
                                    stdin=inputFile, text=True, capture_output=captureOutput)
            if taskIndex != 1:
                output = result.stdout
                output = output.replace("\n", "")
                output = output.replace("\0", "")
            else:
                result = subprocess.run(["cat", "out.txt"], capture_output=True, text=True)
                output = result.stdout
                output = output.replace("\n", "")
                output = output.replace("\0", "")
                subprocess.run(["rm", "in.txt", "out.txt"])
            if output == taskOutputArray[i]:
                estimatedGrade += taskPoints[i]
                print("\tTest " + str(i) + ": OK (" + str(taskPoints[i]) + ")")
            else:
                print("\tTest " + str(i) + " failed (0p)")
                print("\t   Input: ")
                with open(taskInputArray[i], "r") as f:
                    lines = f.readlines()
                    for line in lines:
                        print(line[:-1])
                print("\t   Your output:", output)
                print("\t   Expected output:", taskOutputArray[i])
        except:
            print("\tTest " + str(i) + ": exception! (0p)")
        print("\n")

print("Estimated grade %dp / 100" % (estimatedGrade))
