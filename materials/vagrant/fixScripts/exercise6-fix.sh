#!/bin/bash
#add fix to exercise6-fix here

#!/bin/bash

# Ensure at least 2 arguments are provided
if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <file1> [file2 ... fileN] <destination_folder>"
  exit 1
fi

# Extract destination folder (last argument)
dest_folder="${!#}"

# Determine which server the script is running on
current_host=$(hostname)

if [[ "$current_host" == "server1" ]]; then
  dest_server="server2"
elif [[ "$current_host" == "server2" ]]; then
  dest_server="server1"
else
  echo "Error: Unknown host. This script must be run on server1 or server2."
  exit 1
fi

# Initialize total bytes counter
total_bytes=0

# Iterate over all arguments except the last one
for file in "${@:1:$#-1}"; do
  if [ ! -f "$file" ]; then
    echo "Warning: '$file' not found or not a regular file, skipping."
    continue
  fi

  # Add file size
  size=$(stat -c%s "$file")
  total_bytes=$((total_bytes + size))

  # Copy to destination on the other server
  scp -q "$file" "${dest_server}:${dest_folder}/"
  if [ $? -ne 0 ]; then
    echo "Error copying '$file' to ${dest_server}:${dest_folder}" >&2
    exit 1
  fi
done

# Print only the total number of bytes copied (no text)
echo "$total_bytes"
