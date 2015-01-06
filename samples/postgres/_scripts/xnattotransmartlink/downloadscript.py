from lxml import etree
from datetime import datetime
import pyxnat
import subprocess
import sys
from elementtree.ElementTree import parse

CONFIG_PATH = './'
CONFIG_EXTENSION = ".xml"
XML_DATATYPE = "dataType"
XML_URL = "url"
XML_NAME = "name"
XNAT_SUBJECT = "subject"
XNAT_SESSION = "session"
SEPARATOR = "\t"
OUT_DIR = "./"
DATA_FILE = "xnat.tmd"
MAPPING_FILE = "xnat.tmm"
CACHE = './cache'
TM_STUDY = "Public Studies"
def loadSubjects(interface, project):
    return interface.select.project(project).subjects()

def loadXNAT(xnat_address, username, password, project):
    return pyxnat.Interface(server=xnat_address, user=username, password=password, cachedir=CACHE)

def loadVariableList(project):
    tree = parse(CONFIG_PATH + project + CONFIG_EXTENSION)
    variableRoot = tree.getroot()[0];
    variableList = [[0 for x in xrange(2)] for x in xrange(len(variableRoot))]    
    rowNumber = 0;
    for variable in variableRoot:
        variableList[rowNumber][0] = variable.attrib[XML_DATATYPE]
        variableList[rowNumber][1] = variable.attrib[XML_URL]
        rowNumber += 1
    return variableList

def loadMappingList(project):
    tree = parse(CONFIG_PATH + project + CONFIG_EXTENSION)
    mappingRoot = tree.getroot()[0];
    mappingList = [0 for x in xrange(len(mappingRoot))]
    rowNumber = 0;
    for variable in mappingRoot:
        mappingList[rowNumber] = variable.attrib["name"]
        rowNumber += 1
        
    return mappingList

def loadCustomVariable(interface, variableName, url):
    xml_string = interface._exec(url, "GET")
    scan_tree = etree.XML(xml_string)
    leafs = scan_tree.xpath("//xnat:field[@name='" + variableName + "']/child::text()", namespaces={"xnat":"http://nrg.wustl.edu/xnat"})
    value = ''.join(leafs).replace('\n', '')
    return value

def createVariableURL(dataType, project, subject, experiment):
    if dataType == "subjectvariable":
        return "/data/projects/" + project + "/subjects/" + subject + "?format=xml"
    else:
        return "/data/projects/" + project + "/subjects/" + subject + "/experiments/" + experiment + "?format=xml"

def createDatafile(interface, project, subjects, variableList, mappingList):
    transmartDataFile = open(OUT_DIR + DATA_FILE, 'w')

    for variable in mappingList:
        file.write(transmartDataFile, variable + SEPARATOR)
    file.write(transmartDataFile, "\r\n")
    
    for subject in subjects:
        sessions = subject.experiments()
        for session in sessions:
            for row in variableList:
                dataType = row[0]
                variable = row[1]
                if dataType.lower() == XNAT_SUBJECT.lower():
                    file.write(transmartDataFile, subject.attrs.get(variable))
                elif dataType.lower() == XNAT_SESSION.lower():
		    file.write(transmartDataFile, session.attrs.get(variable))
                elif dataType.lower() == "subjectvariable".lower() or \
		     dataType.lower() == "sessionvariable".lower():
		    file.write(transmartDataFile, 
                        loadCustomVariable(interface, variable, 
                        createVariableURL(dataType, project, subject.id(), session.id())))
                file.write(transmartDataFile, SEPARATOR)
            file.write(transmartDataFile, "\r\n")
    transmartDataFile.close()
    return

def createMappingFile(mappingList):
    transmartMappingFile = open(OUT_DIR + MAPPING_FILE, 'w')
    rowNumber = 1
    group = "XNAT"
    file.write(transmartMappingFile, "filename" + SEPARATOR + "category_cd" + SEPARATOR + "col_nbr" + SEPARATOR + "data_label\r\n")
#   file.write(transmartMappingFile, DATA_FILE + SEPARATOR + SEPARATOR + "1\tSUBJ_ID" + SEPARATOR + SEPARATOR + "\r\n")
    for row in mappingList:
        variable = row
        file.write(transmartMappingFile, DATA_FILE + SEPARATOR + group + SEPARATOR + str(rowNumber) + SEPARATOR + variable + SEPARATOR + SEPARATOR + "\r\n")
        rowNumber+=1
    transmartMappingFile.close()
    return

def runKettleJob(node, kettledir):
    process = subprocess.Popen(["./command.sh", node], cwd=kettledir)
    process.wait()
    return

def main():
    xnat_address = sys.argv[1]
    username = sys.argv[2]
    password = sys.argv[3]
    project = sys.argv[4]
    node = sys.argv[5]
    kettledir = sys.argv[6]

    interface = loadXNAT(xnat_address, username, password, project)
    try:
 	subjects = loadSubjects(interface, project)
    except Exception as e:
	print "Error: %s<br />Please verify if entered password or XNAT connection settings are correct." % e
	return

    variableList = loadVariableList(project)
    mappingList = loadMappingList(project)
    createDatafile(interface, project, subjects, variableList, mappingList)
    createMappingFile(mappingList)
    runKettleJob(node, kettledir)
    print "Import complete! <a target=\"_blank\" href=\"/transmart/datasetExplorer/\">Click here to browse the data in the dataset explorer.</a> The data is stored in node " + TM_STUDY + "\\" + node
    return

main()
