#PBS -S /bin/sh  ###Tells UNIX shell to be executed
#PBS -N Full_Pipeline ###Name of the job
#PBS -l nodes=1:ppn=1 ###Setting the number of nodes and CPUs=ppn
#PBS -t 1-2
#PBS -e /home/mjtiv/towork/Test_Pipeline/Job_Array_Test/$PBS_JOBID.stderr
#PBS -o /home/mjtiv/towork/Test_Pipeline/Job_Array_Test/$PBS_JOBID.stdout

#This code creates numerous submission files, but all depends on one qsub file. 

#Current working directory of the data changes based the variables of 1 or 2 (-t setting)
cd /work/mjtiv/Test_Pipeline/Job_Array_Test/"Sample_"$PBS_ARRAYID
echo /work/mjtiv/Test_Pipeline/Job_Array_Test/"Sample_"$PBS_ARRAYID

#Created a global file list variable (arrays) to put all my fastq files names into

#All global variables are put into arrays for simplicity purposes, especially since there are numerous fastq files
declare -g forward_Primer  #Variable to create an array of the forward primer fastq files
declare -g reverse_Primer  #Variable to create an array of the reverse primer fastq files
declare -g sample_name #Variable for the true sample Name


#Code sorts through a directory and pulls out the fastq files (puts into an array) and the variable sample name txt file (else if arrangement)
for file in *; do
	if [[ $file == *R2_001.fastq.gz ]]; then 
		reverse_Primer[${#reverse_Primer[@]}+1]=$(echo "$file");
	elif [[ $file == *R1_001.fastq.gz ]]; then 
		forward_Primer[${#forward_Primer[@]}+1]=$(echo "$file");
	elif [[ $file == *.txt ]]; then
 		Sample=${file%.txt}
		#Sample_Name[${#Sample_Name[@]}+1]=$(echo "$Sample");
		sample_name=$(echo "$Sample");
	else
		echo "not file type"
	fi
done

#Step Converts the arrays to a list of samples separated by commas NOT white space

#This step is required when submitting multiple files to STAR
reverse_Primer_List=$(IFS=,; echo "${reverse_Primer[*]}")
forward_Primer_List=$(IFS=,; echo "${forward_Primer[*]}")

#Testing the Return of the Sample Lists
echo "Testing Variable List"
echo $reverse_Primer_List
echo $forward_Primer_List
echo $forward_Primer_List $reverse_Primer_List

echo $sample_name
