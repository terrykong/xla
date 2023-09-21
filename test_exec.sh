#!/bin/sh

test_suite_input="${1} ${2}"
fmha_job=${3:-0}
source_dir="/root/.cache/bazel/_bazel_root/"
destination_dir="/logs"
bazel_args="--config=cuda --jobs=200 --test_timeout=3600 --nocheck_visibility --test_output=streamed "
export TF_CUDA_COMPUTE_CAPABILITIES=compute_70

#check input args
if [ -z "$1" ]; then
	echo "Error Input to the script is missing!"
	exit 1
fi

# add fmha args if it's a fmha job
if [ ${fmha_job} -eq 1 ]; then
    bazel_args="${bazel_args} --copt=-Wno-error=switch "
fi

# create the destination dir
mkdir -p $destination_dir

# Execute the bazel command.
bazel test ${bazel_args} ${test_suite_input} 

# find all the log files with .log extension in source directory
log_files=$(find "$source_dir" -type f -name "*.log") 

# Loop through each log file
for file_path in $log_files; do &> /dev/null
    # Extract filename and directory from the file path
    filename=$(basename "$file_path") 
    directory=$(dirname "$file_path") 

    directory_name_truncated=${directory#*k8-opt/} 
    echo "Dir name truncated is: $directory_name_truncated"

    # Generate the new filename with the full path and _ delimeter
    new_filename="${directory_name_truncated//\//_}" 

    # Copy the file to the destination directory with the new filename
    cp "$file_path" "$destination_dir/$new_filename" 
done

file_count=$(ls -p "$destination_dir" | grep -v / | wc -l) 
echo "Copied $file_count files successfully ! "
