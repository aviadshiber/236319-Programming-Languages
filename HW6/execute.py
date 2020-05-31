import subprocess
import tempfile
import time


def execute(command):
    t = time.clock()
    p = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdoutdata, stderrdata = p.communicate()
    t = time.clock() - t
    if p.returncode != 0:
        raise ReturnCodeError(p.returncode)
    
    return stdoutdata, stderrdata, t


class ReturnCodeError(Exception):
    def __init__(self, return_code):
        self.return_code = return_code

    def __str__(self):
        return "Error! Return code was {0}!".format(self.return_code)

# Example:
if __name__ == "__main__":
    command = ["ls", "-l"]
    try:
        stdoutdata, stderrdata, running_time = execute(command)
        print "Command: {0}\nOutput:\n{1}\nRunning Time: {2} seconds".format(" ".join(command), stdoutdata, running_time)
    except ReturnCodeError as e:
        print e


