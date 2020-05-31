from compile import interpate
from compile import execute
import math
import re


def print_table(languages_data):
    head = '<!DOCTYPE html>\n<html>\n<body>\n<table style="width:100%">\n'

    head += '<tr>\n'
    head += '<td><b>Prog-Lang</b></td>\n'
    head += '<td><b>Average time</b></td>\n'
    head += '<td><b>Standard deviation</b></td>\n'
    head += '<td><b>Ifs count</b></td>\n'
    head += '<td><b>Loops count</b></td>\n'
    head += '</tr>\n'

    for lang in languages_data:
        head += '<tr>\n'
        head += '<td><b>%s</b></td>\n' % lang[0]
        head += '<td>%s</td>\n' % lang[1]
        head += '<td>%s</td>\n' % lang[2]
        head += '<td>%s</td>\n' % lang[3]
        head += '<td>%s</td>\n' % lang[4]
        head += '</tr>\n'

    return head


def run_some_times(lang, repeat):
    time_array = [0]*repeat
    stdout = ""
    stderr = ""
    if (lang == 'ML' or lang == 'Python'):
        if (lang == 'ML'):
            process, filepath, inputs = "sml", "ML/hw2.sml", "taxicab();"
        else:
            process, filepath, inputs = "python", "Python/taxicab.py", ""

        for i in range(0, repeat):
            stdoutdata, stderrdata, time_array[i] = interpate(process, filepath, inputs)
            if (stderrdata != ""):  # If failed, try once more
                stdoutdata, stderrdata, time_array[i] = interpate(process, filepath, inputs)
            if (stderrdata == "" and stdout == ""):  # If fine, save output once
                stdout, stderr = stdoutdata, stderrdata
    else:
        if (lang == 'AWK'):
            command = "./AWK/taxi.awk"
        elif (lang == 'Bash'):
            command = "./Bash/taxicab.sh"
        elif (lang == 'Java'):
            command = ['java', '-cp', 'Java', 'TaxiCabIt']
        elif (lang == 'Nim'):
            command = "Nim/taxi"
        elif (lang == 'Pascal'):
            command = "Pascal/hw1"
        for i in range(0, repeat):
            stdoutdata, stderrdata, time_array[i] = execute(command)
            if (stderrdata == "" and stdout == ""):
                stdout, stderr = stdoutdata, stderrdata

    return stdout, stderr, time_array


def analyze_time():
    total_time = 0
    sd = 0
    count = 0

    for time in time_array:
        total_time += time
        count += 1

    avg_time = float(total_time) / count

    for time in time_array:
        sd += (time - avg_time) * (time - avg_time)

    sd = math.sqrt(float(sd) / count)

    return avg_time, sd


def analyze_awk():
    search_obj = re.search(ur'\n.+\s(\d+).+\s(\d+)', stdout, re.M | re.I)
    avg_time, sd = analyze_time()
    loops = search_obj.group(1)
    ifs = search_obj.group(2)
    return 'AWK', avg_time, sd, ifs, loops


def analyze_bash():
    searchObj = re.search(ur'\n.+\s(\d+)\n.+\s(\d+)', stdout, re.M | re.I)
    avg_time, sd = analyze_time()
    loops = searchObj.group(1)
    ifs = searchObj.group(2)
    return 'BASH', avg_time, sd, ifs, loops


def analyze_java():
    searchObj = re.search(ur'[\w|\d]+: (\d+) , .+:(\d+)', stdout, re.M | re.I)
    avg_time, sd = analyze_time()
    loops = searchObj.group(2)
    ifs = searchObj.group(1)
    return 'Java', avg_time, sd, ifs, loops


def analyze_ml():
    searchObj = re.search(ur'it = .+,(\d+),(\d+)', stdout, re.M | re.I)
    avg_time, sd = analyze_time()
    loops = searchObj.group(1)
    ifs = searchObj.group(2)
    return 'ML', avg_time, sd, ifs, loops


def analyze_nim():
    searchObj = re.search(ur'.+\s\d+\n.+\s(\d+)', stdout, re.M | re.I)
    avg_time, sd = analyze_time()
    loops = searchObj.group(1)
    ifs = 0
    return 'Nim', avg_time, sd, ifs, loops


def analyze_pascal():
    search_obj = re.search(ur'.+\s\d+\n.+\s(\d+)', stdout, re.M | re.I)
    avg_time, sd = analyze_time()
    loops = search_obj.group(1)
    ifs = 0
    return 'Pascal', avg_time, sd, ifs, loops

def analyze_python():
    search_obj = re.search(ur'\n.+\s(\d+).+\n.+\s(\d+)', stdout, re.M | re.I)
    avg_time, sd = analyze_time()
    loops = search_obj.group(1)
    ifs = search_obj.group(2)
    return 'Python', avg_time, sd, ifs, loops


def analyze_results(lang):
    if (lang == 'AWK'):
        return analyze_awk()
    elif (lang == 'Bash'):
        return analyze_bash()
    elif (lang == 'Java'):
        return analyze_java()
    elif (lang == 'ML'):
        return analyze_ml()
    elif (lang == 'Nim'):
        return analyze_nim()
    elif (lang == 'Pascal'):
        return analyze_pascal()
    elif (lang == 'Python'):
        return analyze_python()


languages = ['AWK', 'Bash', 'Java', 'ML', 'Nim', 'Pascal', 'Python']
i = 0
languages_data = languages
for lang in languages:
    stdout, stderr, time_array = run_some_times(lang, 20)
    languages_data[i] = analyze_results(lang)
    i += 1
'''
   for data in languages_data[i]:
        print data
'''

html_file = open("taxi_table.html", "w")
html_file.write(print_table(languages_data))
html_file.close()


