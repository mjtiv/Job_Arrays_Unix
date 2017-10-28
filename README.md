# Job_Arrays_Unix
Example Job Array Code (Torque) With Automatic Parsing of Files

This code shows how to utilize a job array submission that automatically loads the required data from a certain file type 
into a list and then passes that information to a desired program very analysis

Specifically this program loads fastq files from a specific directory and passes that information to a list for loading
into a specific program. Specifically in this example was developed to parse files to load into STAR.

The "for" loop can easily be modified to take in a different type of file to be uploaded into a different program.
