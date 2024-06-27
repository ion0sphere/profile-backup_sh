#!/bin/sh




#define group name
group_name="profilebackup"

#define destination_directory
dest_dir="/mnt/profilebackup"

#define folders in user home directories to back up
#format="folder1 folder2 folder3"
home_folders=" "



#stop execution on any error
set -e


#check /etc/group for $groupname and add it if nonexistent
if ! grep -q $group_name /etc/group 
then
	groupadd $group_name
	echo "$group_name has been added to groups"
else
	echo "$group_name: group is present"
fi


#check if destination_dir is active
if [ -d "$dest_dir" ];
then
	echo "$dest_dir: directory is present"

	#check for "backups" folder and create if not present
	if [ ! -d "$dest_dir/backups" ]
	then 
		mkdir $dest_dir/backups
		echo "$dest_dir/backups has been created"
	else
		echo "$dest_dir/backups: folder is present"
	fi
else
	echo "$dest_dir: is not present"
fi	



#for each user in group:

#example line from /etc/group:	groupname:x:1000:adam,bob,charlie
#pull memberlist = grep line from file | remove prefix before ":" delimiter | QUES: Separate output by ',' delimiter to create multiple items if more than one user 
member_list=$(grep $group_name /etc/group | sed -e "s/^.*://")

echo $member_list
#IFS=',' read -a memberarray <<< "$member_list"
#echo ${memberarray[*]}

#for member in $member_list
#do
#	echo $member
#done	


	

	#check if user has an existing folder in destination_directory and create if not present
	#copy defined folders to destination_directory/{user}/
	#check for errors
