import csv

#dic = {"John": "john@example.com", "Mary": "mary@example.com"} #dictionary

download_dir = "exampleCsv.csv" #where you want the file to be downloaded to 

#csv = open(download_dir, "w") 
#"w" indicates that you're writing strings to the file

#columnTitleRow = "name, email\n"
#csv.write(columnTitleRow)


with open(download_dir,'r') as newFile:
    newFileWriter = csv.writer(newFile)
    newFileWriter.writerow(['user_id','beneficiary'])
    newFileWriter.writerow([1,'xyz'])
    newFileWriter.writerow([2,'pqr'])

#for key in dic.keys():
#	name = key
#	email = dic[key]
#	row = name + "," + email + "\n"
#	csv.write(row)
