#!/usr/bin/python3

import re
import sys
import shutil
block_regex = r"[A-Za-z0-9_]+\n#\([^;]*\);"
nf_regex = r"^\.nf[^\d]*(\d+)[^\d]*,$"
formula_regex = r"\( \"\'(.*) \)"
loose_digit_regex = r"\"\'\d\.\d+"

file = sys.argv[1]
shutil.copyfile(file, "out.v")
netlist = ""
with open("out.v", "r") as file:
    netlist = file.read()

matches = re.finditer(block_regex, netlist, re.MULTILINE)
for match in matches:
    # All matched components
    component = match.group(0)
    if "int" in component:
        # the word in the component definition is problematic
        new_component = ""
        nf = 0
        for line in component.splitlines():
            # All formulas contain nf, so search for the nf value of the block
            nf_match = re.search(nf_regex, line)
            if nf_match:
                nf = int(nf_match.group(1))
            if "\"'" in line:
                # All faulty lines start with "', so filter those
                # Now there are 2 options
                # 1. The line contains a formula which should be computed
                # 2. The line contains a digit which should be without "'
                if "int" in line:
                    formula = re.search(formula_regex, line)
                    line = line.replace(f"\"\'{formula.group(1)}", f"{eval(formula.group(1))}")
                else:
                    line = line.replace("\"\'", "")
                # print(line)
                # print(eval("2*int((nf+1)/2)"))
            new_component = "\n".join([new_component, line])
    # Remove leading newline caused by join
    # new_component = new_component.lstrip()
    netlist = netlist.replace(component, new_component)
    

with open("out.v", "w") as file:
    file.write(netlist)