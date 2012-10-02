import urllib
import sys
import os
import subprocess

remote_base = "http://www.epa.gov/otaq/cert/documents/cert-tst/"
final_data_path = "../../data/raw-csv/"

def getdata_xls(i):
    fin_xls =  final_data_path + "%sactrr.xls" %i
    fin_csv =  final_data_path + "actrr-%s.csv" %i
    urllib.urlretrieve(remote_base + "%sactrr.xls" %i, fin_xls) 
    os.system("xls2csv %s > %s" %(fin_xls, fin_csv))
    subprocess.call(["rm", fin_xls])

def getdata_zip(i):
    fin_xls =  final_data_path + "%sactrr.xls" %i
    fin_csv =  final_data_path + "actrr-%s.csv" %i
    urllib.urlretrieve(remote_base + "%sactrr.xls" %i, fin_xls) 
    os.system("xls2csv %s > %s" %(fin_xls, fin_csv))
    subprocess.call(["rm", fin_xls])

for i in ["10", "11", "12", "13"]:
    final_file_name = "actrr-%s.csv" %i
    if os.path.exists(final_data_path + final_file_name):
        print("File already downloaded and cleaned for 20%s" %i)
    else: 
        getdata_xls(i)

for i in ["08", "09"]:
    final_file_name = "actrr-%s.csv" %i
    if os.path.exists(final_data_path + final_file_name):
        print("File already downloaded and cleaned for 20%s" %i)
    else: 
        getdata_csv(i)


            

# http://www.epa.gov/otaq/cert/veh-cert/cert-tst/00db.zip
# http://www.epa.gov/otaq/cert/veh-cert/cert-tst/01db.zip
