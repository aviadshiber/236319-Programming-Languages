import time
import subprocess


def interpate(process, filepath, inputs):
    t = time.clock()
    p = subprocess.Popen(process, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    f = open(filepath)
    data = f.read()
    f.close()
    data += inputs
    print data
    stdoutdata, stderrdata = p.communicate(input=data)
    print stderrdata
    t = time.clock() - t
    if p.returncode != 0:
        raise ReturnCodeError(p.returncode)

    return stdoutdata, stderrdata, t


def execute(command):
    t = time.clock()
    p = subprocess.Popen(command, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdoutdata, stderrdata = p.communicate()
    print stderrdata
    t = time.clock() - t
    if p.returncode != 0:
        raise ReturnCodeError(p.returncode)

    return stdoutdata, stderrdata, t


class ReturnCodeError(Exception):
    def __init__(self, return_code):
        self.return_code = return_code

    def __str__(self):
        return "Error! Return code was {0}!".format(self.return_code)


if __name__ == "__main__":
    pascalCompile = ["fpc", "Pascal/hw1.pas"]
    javaCompile = ["javac", "Java/Cube.java", "Java/CubePairs.java", "Java/LongPair.java", "Java/TaxiCabIt.java"]
    nimCompile = ["nim", "compile", "Nim/taxi.nim"]
    pythonCompile = ["python", "-m", "py_compile", "Python/taxicab.py"]

    commands = [pascalCompile, javaCompile, nimCompile, pythonCompile]
    try:
        # interpate("sml","ML/hw2.sml","taxicab();")
        for command in commands:
            stdoutdata, stderrdata, running_time = execute(command)
            print "runs the following commands to compile: {0}\nOutput:\n{1}\nRunning Time: {2} seconds".format(
                " ".join(command), stdoutdata, running_time)
    except ReturnCodeError as e:
        print e
    print "end"
else:
    print "this is not main"
